#!/usr/bin/env python3
"""
Documentation Manager for infrastructure-validation project
Manages documentation structure, manifest generation, and consistency checks.
"""

import json
import os
import subprocess
import sys
import argparse
import re
from pathlib import Path
from datetime import datetime


class DocManager:
    def __init__(self, project_root: str | None = None):
        self.project_root = Path(project_root) if project_root else Path(os.getcwd())
        self.docs_dir = self.project_root / "docs"
        self.manifest_path = self.project_root / "docs_manifest.json"

    def verify_git_integrity(self) -> bool:
        """
        Pre-flight check to prevent Git 'Ghost Object' errors.
        Ensures the local object database and index are in sync.
        """
        print("🔍 Verifying Git Integrity...")
        try:
            # Check for corrupted or unreachable objects
            subprocess.run(
                ["git", "fsck", "--unreachable"], check=True, capture_output=True
            )
            # Verify the index can be read without errors
            subprocess.run(["git", "ls-files"], check=True, capture_output=True)
            print("✅ Git Index: Healthy")
            return True
        except subprocess.CalledProcessError as e:
            error_msg = e.stderr.decode() if e.stderr else "Unknown Git error"
            print(f"❌ GIT CORRUPTION DETECTED: {error_msg}")
            print("💡 Suggestion: Run 'rm .git/index && git reset'")
            return False

    def generate_manifest(self) -> dict:
        return {
            "project": self.project_root.name,
            "generated": datetime.now().isoformat(),
            "structure": {
                "product": str(self.docs_dir / "en" / "product"),
                "legal": str(self.docs_dir / "en" / "legal"),
                "architecture": str(self.docs_dir / "architecture"),
                "adr": str(self.docs_dir / "architecture" / "adr"),
            },
            "files": self._scan_documentation(),
        }

    def _scan_documentation(self) -> dict:
        files = {}
        if not self.docs_dir.exists():
            return files
        for doc_path in self.docs_dir.rglob("*.md"):
            rel_path = doc_path.relative_to(self.docs_dir)
            files[str(rel_path)] = {
                "path": str(doc_path),
                "size": doc_path.stat().st_size,
                "modified": datetime.fromtimestamp(
                    doc_path.stat().st_mtime
                ).isoformat(),
            }
        return files

    def write_manifest(self):
        manifest = self.generate_manifest()
        with open(self.manifest_path, "w") as f:
            json.dump(manifest, f, indent=2)
        print(f"✅ Documentation manifest written to {self.manifest_path}")

    def generate_index(self, force: bool = False):
        """
        Generates or updates the documentation index in docs/README.md.
        Preserves existing content by using markers or appending.
        """
        index_path = self.docs_dir / "README.md"

        # Ensure docs directory exists
        if not self.docs_dir.exists():
            self.docs_dir.mkdir(parents=True, exist_ok=True)

        # Generate the TOC content
        manifest = self.generate_manifest()
        toc_lines = [
            "## 📚 Documentation Index",
            f"*Last updated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}*",
            "",
        ]

        # Group files by directory for a better TOC
        files_by_dir = {}
        for rel_path, info in sorted(manifest["files"].items()):
            if rel_path == "README.md":
                continue
            parent = str(Path(rel_path).parent)
            if parent not in files_by_dir:
                files_by_dir[parent] = []
            files_by_dir[parent].append(rel_path)

        for directory, files in sorted(files_by_dir.items()):
            dir_name = (
                directory.replace(os.sep, " / ").title()
                if directory != "."
                else "General"
            )
            toc_lines.append(f"### {dir_name}")
            for f in files:
                name = Path(f).stem.replace("-", " ").replace("_", " ").title()
                toc_lines.append(f"- [{name}]({f})")
            toc_lines.append("")

        new_index_content = "\n".join(toc_lines)

        start_marker = "<!-- START_DOC_INDEX -->"
        end_marker = "<!-- END_DOC_INDEX -->"
        wrapped_content = f"{start_marker}\n{new_index_content}\n{end_marker}"

        if index_path.exists() and not force:
            with open(index_path, "r") as f:
                current_content = f.read()

            if start_marker in current_content and end_marker in current_content:
                # Replace content between markers
                pattern = f"{re.escape(start_marker)}.*?{re.escape(end_marker)}"
                updated_content = re.sub(
                    pattern, wrapped_content, current_content, flags=re.DOTALL
                )
                with open(index_path, "w") as f:
                    f.write(updated_content)
                print(f"✅ Documentation index updated in {index_path}")
            else:
                # Append to existing file
                with open(index_path, "a") as f:
                    f.write(f"\n\n{wrapped_content}\n")
                print(f"✅ Documentation index appended to {index_path}")
        else:
            # Create new file or overwrite if forced
            with open(index_path, "w") as f:
                f.write(f"# Project Documentation\n\n{wrapped_content}\n")
            print(f"✅ Documentation index created at {index_path}")

    def check(self):
        print("🔍 Running documentation checks...")
        required_dirs = [
            self.docs_dir / "en" / "product",
            self.docs_dir / "en" / "legal",
            self.docs_dir / "architecture" / "adr",
        ]
        for dir_path in required_dirs:
            status = "✅ Found" if dir_path.exists() else "⚠️ Missing"
            print(f"{status}: {dir_path}")

    def run(self, check_only: bool = False, force_index: bool = False):
        if not self.verify_git_integrity():
            sys.exit(1)
        if check_only:
            self.check()
        else:
            self.write_manifest()
            self.generate_index(force=force_index)
            self.check()


def main():
    parser = argparse.ArgumentParser(description="Documentation Manager")
    parser.add_argument("--check", action="store_true", help="Run checks only")
    parser.add_argument(
        "--integrity", action="store_true", help="Run Git integrity check only"
    )
    parser.add_argument(
        "--force-index",
        action="store_true",
        help="Force overwrite of documentation index",
    )
    parser.add_argument("--root", default=None, help="Project root directory")
    args = parser.parse_args()

    manager = DocManager(project_root=args.root)
    if args.integrity:
        sys.exit(0 if manager.verify_git_integrity() else 1)
    manager.run(check_only=args.check, force_index=args.force_index)


if __name__ == "__main__":
    main()
