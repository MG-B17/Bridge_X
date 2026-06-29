import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  late final SupabaseClient client;

  Future<void> init() async {
    await Supabase.initialize(
      url: 'https://ltssssiphjiimiozxeuu.supabase.co',
      publishableKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx0c3Nzc2lwaGppaW1pb3p4ZXV1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODExMjQ2MDUsImV4cCI6MjA5NjcwMDYwNX0.pjMLyIKtxqKQKq0lr3YUs-RMD_eGFpQfM2BD9E3n10M',
    );
    client = Supabase.instance.client;
  }
}
