import 'package:flutter/material.dart';

// COLORS (consistent with your theme)
const bgColor = Color(0xFFF8F4EF);
const cardBg = Colors.white;
const charcoal = Color(0xFF232325);
const subtleGray = Color(0xFFEEEEEE);
const gold = Color(0xFFD4AF37);

class ReservationScreen extends StatefulWidget {
  final String restaurantName;
  const ReservationScreen({required this.restaurantName, Key? key}) : super(key: key);

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  final _formKey = GlobalKey<FormState>();
  int guests = 2;
  DateTime? date;
  TimeOfDay? time;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final requestController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      // backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: charcoal,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(
          'Reserve at ${widget.restaurantName}',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontFamily: 'Georgia',
            fontSize: 20,
            letterSpacing: -1,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Card background for the form
              Container(
                margin: const EdgeInsets.fromLTRB(0, 18, 0, 0),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _FancyInput(
                        controller: nameController,
                        label: 'Full Name',
                        validator: (v) =>
                        v == null || v.trim().isEmpty ? "Enter your name" : null,
                      ),
                      const SizedBox(height: 15),
                      _FancyInput(
                        controller: phoneController,
                        label: 'Phone Number',
                        keyboardType: TextInputType.phone,
                        validator: (v) =>
                        v == null || v.trim().isEmpty ? "Phone required" : null,
                      ),
                      const SizedBox(height: 15),
                      _FancyInput(
                        controller: emailController,
                        label: 'Email Address (optional)',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 21),
                      // Guests Picker
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 28,
                              child: Center(
                                child: Icon(Icons.groups_rounded, color: charcoal, size: 25),
                              ),
                            ),
                            const SizedBox(width: 7),
                            Text(
                              'Number of Guests',
                              style: textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Georgia',
                                fontSize: 15.3,
                                color: charcoal,
                              ),
                            ),
                            const Spacer(),
                            _GuestPicker(
                              guests: guests,
                              onChanged: (v) => setState(() => guests = v),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 21),
                      // Date Picker
                      _PickerInput(
                        icon: Icons.calendar_month_rounded,
                        label: "Date",
                        value: date == null
                            ? 'Pick a date'
                            : "${date!.year}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: date ?? DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(const Duration(days: 365)),
                            builder: (context, child) => Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: gold,
                                  onPrimary: charcoal,
                                  surface: cardBg,
                                ),
                              ),
                              child: child!,
                            ),
                          );
                          if (picked != null) setState(() => date = picked);
                        },
                      ),
                      const SizedBox(height: 15),
                      // Time Picker
                      _PickerInput(
                        icon: Icons.access_time_rounded,
                        label: "Time",
                        value: time == null
                            ? 'Pick a time'
                            : "${time!.format(context)}",
                        onTap: () async {
                          final picked = await showTimePicker(
                            context: context,
                            initialTime: time ?? TimeOfDay(hour: 19, minute: 0),
                            builder: (context, child) => Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: gold,
                                  onPrimary: charcoal,
                                ),
                              ),
                              child: child!,
                            ),
                          );
                          if (picked != null) setState(() => time = picked);
                        },
                      ),
                      const SizedBox(height: 15),
                      _FancyInput(
                        controller: requestController,
                        label: 'Special Requests (optional)',
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // Bottom sticky button
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 7, 12, 14),
          child: SizedBox(
            height: 54,
            child: FilledButton.icon(
              icon: const Icon(Icons.event_available, color: Colors.white, size: 23),
              label: const Text(
                'Reserve Table',
                style: TextStyle(
                  fontFamily: 'Georgia',
                  fontWeight: FontWeight.bold,
                  fontSize: 17.2,
                  letterSpacing: -0.7,
                ),
              ),
              style: FilledButton.styleFrom(
                backgroundColor: charcoal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
                elevation: 3,
                textStyle: const TextStyle(
                  fontFamily: 'Georgia',
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // You could show a confirmation dialog/snackbar here!
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Reservation submitted!')),
                  );
                  // TODO: API logic or navigation
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

// --- Helper Widgets ---
// Input field with premium style
class _FancyInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType? keyboardType;
  final int maxLines;
  final String? Function(String?)? validator;
  const _FancyInput({
    required this.controller,
    required this.label,
    this.keyboardType,
    this.maxLines = 1,
    this.validator,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      style: const TextStyle(
        fontFamily: 'Georgia',
        fontWeight: FontWeight.w600,
        color: charcoal,
        fontSize: 15.2,
      ),
      decoration: InputDecoration(
        hintText: label,
        hintStyle: const TextStyle(
          color: charcoal,
          fontWeight: FontWeight.w600,
          fontFamily: 'Georgia',
          fontSize: 15.2,
        ),
        filled: true,
        fillColor: subtleGray,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: subtleGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: gold, width: 2),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
    );
  }
}

// Guests counter with gold highlight
class _GuestPicker extends StatelessWidget {
  final int guests;
  final void Function(int) onChanged;
  const _GuestPicker({required this.guests, required this.onChanged, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _CircleIconBtn(
          icon: Icons.remove,
          onTap: guests > 1 ? () => onChanged(guests - 1) : null,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            '$guests',
            style: const TextStyle(
              color: charcoal,
              fontWeight: FontWeight.w800,
              fontFamily: 'Georgia',
              fontSize: 16.7,
            ),
          ),
        ),
        _CircleIconBtn(
          icon: Icons.add,
          fillColor: guests < 20 ? gold : subtleGray,
          iconColor: guests < 20 ? charcoal : Colors.grey,
          onTap: guests < 20 ? () => onChanged(guests + 1) : null,
        ),
      ],
    );
  }
}

class _CircleIconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final Color fillColor;
  final Color iconColor;
  const _CircleIconBtn({
    required this.icon,
    this.onTap,
    this.fillColor = subtleGray,
    this.iconColor = charcoal,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: fillColor,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 28,
          height: 28,
          child: Icon(icon, color: iconColor, size: 18),
        ),
      ),
    );
  }
}

// Outlined picker for date & time
class _PickerInput extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;
  const _PickerInput({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isEmpty = value.contains('Pick');
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 0),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        decoration: BoxDecoration(
          color: subtleGray,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isEmpty ? subtleGray : gold,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: charcoal, size: 22),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                color: charcoal,
                fontWeight: FontWeight.bold,
                fontFamily: 'Georgia',
                fontSize: 15.2,
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  color: isEmpty ? charcoal.withOpacity(.48) : charcoal,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Georgia',
                  fontSize: 15.2,
                ),
                textAlign: TextAlign.right,
              ),
            ),
            const SizedBox(width: 3),
            Icon(Icons.arrow_forward_ios_rounded, size: 16, color: charcoal.withOpacity(.33)),
          ],
        ),
      ),
    );
  }
}
