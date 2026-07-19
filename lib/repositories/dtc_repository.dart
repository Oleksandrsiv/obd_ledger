import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import '../data/database/daos/dtc_dao.dart';
import '../data/models/diagnostic_code.dart';
import '../services/obd_service/iobd_service.dart';

class DtcRepository {
  final IObdScanner _obdScanner;
  final DtcDao _dtcDao;

  // Store the loaded JSON in memory to avoid reading the file from disk for each code
  Map<String, dynamic>? _standardDtcMap;

  DtcRepository(this._obdScanner, this._dtcDao);

  Future<List<DiagnosticCode>> getTroubleCodes(String make) async {
    // Get raw codes from the car
    final rawCodes = await _obdScanner.readTroubleCodes();

    if (rawCodes.isEmpty) return [];

    // Load the JSON dictionary if not already loaded
    await _loadStandardDtcCache();

    List<DiagnosticCode> result = [];

    // Decode each code
    for (String code in rawCodes) {
      if (code.length < 5) continue; // Protect against bad data

      // Check second character: if '0' - it's a standard code (e.g. P0xxx)
      bool isStandard = code[1] == '0';

      String description = "Unknown error";

      if (isStandard) {
        // --- LOCAL PARSING (from JSON) ---
        description = _standardDtcMap?[code] ?? "Description for standard code not found";
      } else {
        // --- SPECIFIC PARSING (P1xxx, P2xxx etc.) ---
        // First look up in the SQLite cache
        final cachedDesc = await _dtcDao.getDescription(code);

        if (cachedDesc != null) {
          description = cachedDesc;
        }
      }

      result.add(DiagnosticCode(
        code: code,
        description: description,
        isStandard: isStandard,
      ));
    }

    return result;
  }

  /// Read JSON file from assets and convert to Map
  Future<void> _loadStandardDtcCache() async {
    if (_standardDtcMap != null) return; // Already loaded
    try {
      final jsonString = await rootBundle.loadString('assets/standard_dtc.json');
      _standardDtcMap = jsonDecode(jsonString);
    } catch (e) {
      log("Error loading error dictionary: $e");
      _standardDtcMap = {};
    }
  }

  Future<bool> clearTroubleCodes() async {
    return await _obdScanner.clearTroubleCodes();
  }


}