import 'package:taning/features/tanings/domain/entities/taning.dart';

/// Abstract repository interface for Taning data operations
abstract class TaningRepository {
  /// Get all Tanings
  Future<List<Taning>> getAll();
  
  /// Get active Tanings (not completed, not archived)
  Future<List<Taning>> getActive();
  
  /// Get completed Tanings
  Future<List<Taning>> getCompleted();
  
  /// Get archived Tanings
  Future<List<Taning>> getArchived();
  
  /// Get a single Taning by ID
  Future<Taning?> getById(String id);
  
  /// Save a Taning (create or update)
  Future<Taning> save(Taning taning);
  
  /// Delete a Taning by ID
  Future<void> delete(String id);
  
  /// Mark a Taning as completed
  Future<Taning> markCompleted(String id);
  
  /// Archive a Taning
  Future<Taning> archive(String id);
  
  /// Unarchive a Taning
  Future<Taning> unarchive(String id);
  
  /// Pin/Unpin a Taning
  Future<Taning> togglePin(String id);
  
  /// Watch all Tanings (for real-time updates)
  Stream<List<Taning>> watchAll();
  
  /// Watch active Tanings (for real-time updates)
  Stream<List<Taning>> watchActive();
}