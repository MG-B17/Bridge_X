import os

def process_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        lines = f.readlines()
    
    modified = False
    needs_go_router = False
    needs_app_route = False

    for i in range(len(lines)):
        if 'context.colors.background' in lines[i]:
            lines[i] = lines[i].replace('context.colors.background', 'context.colors.scaffoldBg')
            modified = True
            
        if 'context.colors.success' in lines[i]:
            lines[i] = lines[i].replace('context.colors.success', 'context.colors.completedText')
            modified = True
        
        if 'context.pop(' in lines[i] or 'context.push(' in lines[i] or 'context.go(' in lines[i]:
            needs_go_router = True
            
        if 'AppRouteConstant' in lines[i]:
            needs_app_route = True

    if needs_go_router and not any("import 'package:go_router/go_router.dart';" in line for line in lines):
        lines.insert(0, "import 'package:go_router/go_router.dart';\n")
        modified = True
        
    if needs_app_route and not any("app_route_constant.dart" in line for line in lines):
        # We don't know exact depth, but usually it's in core/navigation/app_route_constant.dart
        # Let's count depth by looking at other core imports
        depth = 0
        for line in lines:
            if '/core/' in line:
                parts = line.split('/core/')
                dots = parts[0].count('../')
                if dots > 0:
                    lines.insert(1, f"import '{'../' * dots}core/navigation/app_route_constant.dart';\n")
                    modified = True
                    break
        else:
            # Fallback if no /core/ import found
            pass

    if modified:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.writelines(lines)
        print(f"Fixed {filepath}")

for root, _, files in os.walk('lib'):
    for file in files:
        if file.endswith('.dart'):
            process_file(os.path.join(root, file))
