#!/usr/bin/env python3
import sys
import os
import plistlib

def main():
    if len(sys.argv) < 2:
        print("Usage: set_iterm_font.py <font_name> [font_size]", file=sys.stderr)
        sys.exit(1)

    font_name = sys.argv[1]
    font_size = sys.argv[2] if len(sys.argv) > 2 else "12"
    font_value = f"{font_name} {font_size}"

    path = os.path.expanduser('~/Library/Preferences/com.googlecode.iterm2.plist')
    if not os.path.exists(path):
        print(f"File not found: {path}", file=sys.stderr)
        sys.exit(0)

    with open(path, 'rb') as f:
        plist = plistlib.load(f)

    modified = False
    for profile in plist.get('New Bookmarks', []):
        profile['Normal Font'] = font_value
        modified = True

    if modified:
        with open(path, 'wb') as f:
            plistlib.dump(plist, f)

if __name__ == '__main__':
    main()
