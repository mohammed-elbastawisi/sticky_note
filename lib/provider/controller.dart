abstract class Controller<T> {
  T findNoteById(String id);

  Future<void> addNewNote(T newNote);

  Future<void> fetchNoteData();

  Future<void> updateNoteData(String id, T newNote);

  Future<void> deleteNoteData(String id);
}
