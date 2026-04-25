import os

dialog_path = 'lib/core/widgets/bridge_dialog.dart'
if os.path.exists(dialog_path):
    with open(dialog_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # replace incorrect relative paths
    content = content.replace("'../../theme/app_color.dart'", "'../theme/app_color.dart'")
    content = content.replace("'../../theme/text_style.dart'", "'../theme/text_style.dart'")
    content = content.replace("'../../utils/extensions.dart'", "'../utils/extensions.dart'")
    content = content.replace("'../v_space.dart'", "'v_space.dart'")
    content = content.replace("'../bridge_app_button.dart'", "'bridge_app_button.dart'")
    
    with open(dialog_path, 'w', encoding='utf-8') as f:
        f.write(content)
