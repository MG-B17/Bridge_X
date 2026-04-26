import os

# Fix bridge_dialog.dart imports
dialog_path = 'lib/core/widgets/bridge_dialogs.dart'
if os.path.exists(dialog_path):
    with open(dialog_path, 'r', encoding='utf-8') as f:
        content = f.read()
    if 'package:flutter/material.dart' in content:
        if 'v_space.dart' not in content:
            content = content.replace("import 'package:flutter/material.dart';", "import 'package:flutter/material.dart';\nimport 'v_space.dart';\nimport '../utils/extensions.dart';\nimport 'bridge_app_button.dart';")
        with open(dialog_path, 'w', encoding='utf-8') as f:
            f.write(content)
            
# Also check bridge_dialog.dart if it exists
dialog_path2 = 'lib/core/widgets/bridge_dialog.dart'
if os.path.exists(dialog_path2):
    with open(dialog_path2, 'r', encoding='utf-8') as f:
        content = f.read()
    if 'package:flutter/material.dart' in content:
        if 'v_space.dart' not in content:
            content = content.replace("import 'package:flutter/material.dart';", "import 'package:flutter/material.dart';\nimport 'v_space.dart';\nimport '../utils/extensions.dart';\nimport 'bridge_app_button.dart';")
        with open(dialog_path2, 'w', encoding='utf-8') as f:
            f.write(content)

# Fix relative paths
for root, _, files in os.walk('lib'):
    for file in files:
        if file.endswith('.dart'):
            filepath = os.path.join(root, file)
            with open(filepath, 'r', encoding='utf-8') as f:
                lines = f.readlines()
            
            modified = False
            for i in range(len(lines)):
                if "'../../../core/navigation/app_route_constant.dart'" in lines[i]:
                    lines[i] = lines[i].replace("'../../../core/navigation/app_route_constant.dart'", "'../../../../core/navigation/app_route_constant.dart'")
                    modified = True
                
                # Fix AppColors ambiguous import in no_teams_screen
                if 'no_teams_screen.dart' in filepath and 'import' in lines[i] and 'app_color.dart' in lines[i]:
                    lines[i] = ""
                    modified = True

            if modified:
                with open(filepath, 'w', encoding='utf-8') as f:
                    f.writelines(lines)
                print(f"Fixed paths in {filepath}")
