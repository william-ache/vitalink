import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/config/app_config.dart';
import '../../core/theme/app_theme.dart';

class VitalButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final Color? backgroundColor;
  final bool isSecondary;

  const VitalButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.backgroundColor,
    this.isSecondary = false,
  });

  @override
  Widget build(BuildContext context) {
    final double scale = AppConfig.scaleNotifier.value;
    
    return SizedBox(
      width: double.infinity,
      height: AppConfig.dynamicButtonHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSecondary ? Colors.white : (backgroundColor ?? AppTheme.primaryTeal),
          foregroundColor: isSecondary ? AppTheme.primaryTeal : Colors.white,
          side: isSecondary ? const BorderSide(color: AppTheme.primaryTeal, width: 1) : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: isSecondary ? 0 : 0, // Design system uses flat buttons
          padding: EdgeInsets.symmetric(horizontal: 16 * scale),
        ),
        onPressed: () {
          HapticFeedback.mediumImpact();
          onPressed();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20 * scale),
              SizedBox(width: 8 * scale),
            ],
            Flexible(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18 * scale,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
