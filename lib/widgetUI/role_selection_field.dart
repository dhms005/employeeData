import 'package:employeedata/utils/appColors.dart';
import 'package:employeedata/utils/appImagePath.dart';
import 'package:employeedata/utils/appStrings.dart';
import 'package:employeedata/widgetUI/textRobotoFont.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RoleSelectionField extends StatefulWidget {
  final TextEditingController controller;

  RoleSelectionField({required this.controller});

  @override
  _RoleSelectionFieldState createState() => _RoleSelectionFieldState();
}

class _RoleSelectionFieldState extends State<RoleSelectionField> {
  void _showRoleDialog() async {
    String? role = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Role"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: AppStrings.employeeRoles.map((role) {
              return ListTile(
                title: Text(role),
                onTap: () => Navigator.pop(context, role),
              );
            }).toList(),
          ),
        );
      },
    );

    if (role != null) {
      setState(() {
        widget.controller.text = role; // ✅ Store selected role in controller
      });
    }
  }

  void _showRoleBottomSheet() async {
    String? selectedRole = await showModalBottomSheet<String>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Wrap(
          children: AppStrings.employeeRoles.map((role) {
            return ListTile(
              title: TextRobotoFont(title: role, textAlign: TextAlign.center,fontColor: AppColors.editTextColor,fontSize: 16,),
              onTap: () => Navigator.pop(context, role),
            );
          }).toList(),
        );
      },
    );

    if (selectedRole != null) {
      setState(() {
        widget.controller.text = selectedRole;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showRoleBottomSheet,
      child: AbsorbPointer(
        child: TextFormField(
          controller: widget.controller,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: AppColors.editTextColor,
          ),
          decoration: InputDecoration(
            hintText: AppStrings.selectRole,
            hintStyle: TextStyle(
              color: AppColors.editTextHintColor,
              fontFamily: 'Roboto',
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.all(9), // Adjust padding if needed
              child: SvgPicture.asset(
                AppImagePath.imgWork,
                height: 15,
                width: 15,
                colorFilter: const ColorFilter.mode(AppColors.mainColor,
                    BlendMode.srcIn), // Optional: Change color
              ),
            ),
            suffixIcon: Padding(
              padding: EdgeInsets.all(14), // Adjust padding if needed
              child: SvgPicture.asset(
                AppImagePath.imgArrowDropDown,
                height: 10,
                width: 10,
                colorFilter: const ColorFilter.mode(AppColors.mainColor,
                    BlendMode.srcIn), // Optional: Change color
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5), // Rounded corners
              borderSide:
                  BorderSide(color: AppColors.editTextBorderColor, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                  color: AppColors.editTextBorderColor,
                  width: 1), // Light grey border
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                  color: AppColors.editTextBorderColor,
                  width: 1), // Highlight on focus
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:
              BorderSide(color: Colors.red, width: 1), // Red on focus
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          ),
          validator: (value) =>
              value!.isEmpty ? AppStrings.enterEmployeeRole : null,
        ),
      ),
    );
  }
}
