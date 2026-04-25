import os

dialog_path = 'lib/core/widgets/bridge_dialog.dart'
if os.path.exists(dialog_path):
    with open(dialog_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # ensure imports are added
    imports = """import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'v_space.dart';
import 'bridge_app_button.dart';
import '../utils/extensions.dart';
"""
    if "import 'v_space.dart';" not in content:
        # replace the first import with all imports
        lines = content.split('\n')
        for i, line in enumerate(lines):
            if line.startswith('import'):
                lines[i] = imports
                break
        
        with open(dialog_path, 'w', encoding='utf-8') as f:
            f.write('\n'.join(lines))

no_teams_path = 'lib/features/matching/presentation/screens/no_teams_screen.dart'
if os.path.exists(no_teams_path):
    with open(no_teams_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    if 'AppColors.' in content:
        content = content.replace('AppColors.', 'context.colors.')
        with open(no_teams_path, 'w', encoding='utf-8') as f:
            f.write(content)
