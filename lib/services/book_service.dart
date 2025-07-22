import '../models/book.dart';

class BookService {
  static final BookService _instance = BookService._internal();
  factory BookService() => _instance;
  BookService._internal();

  // Mock data - in real app, this would come from API/Database
  final List<Book> _books = [
    Book(
      id: '1',
      title: 'The Alchemist',
      author: 'Paulo Coelho',
      isbn: '978-0062315007',
      category: 'Fiction',
      description: 'A philosophical novel about following dreams.',
      publishedDate: DateTime(1988, 5, 1),
      isAvailable: true,
    ),
    Book(
      id: '2',
      title: 'Clean Code',
      author: 'Robert C. Martin',
      isbn: '978-0132350884',
      category: 'Technology',
      description: 'A handbook of agile software craftsmanship.',
      publishedDate: DateTime(2008, 8, 1),
      isAvailable: false,
      borrowedBy: 'user123',
      borrowedDate: DateTime.now().subtract(const Duration(days: 5)),
      dueDate: DateTime.now().add(const Duration(days: 9)),
    ),
    Book(
      id: '3',
      title: 'Sapiens',
      author: 'Yuval Noah Harari',
      isbn: '978-0062316097',
      category: 'History',
      description: 'A brief history of humankind.',
      publishedDate: DateTime(2011, 2, 1),
      isAvailable: true,
    ),
    Book(
      id: '4',
      title: 'The Pragmatic Programmer',
      author: 'David Thomas',
      isbn: '978-0201616224',
      category: 'Technology',
      description: 'Your journey to mastery.',
      publishedDate: DateTime(1999, 10, 1),
      isAvailable: true,
    ),
  ];

  Future<List<Book>> getAllBooks() async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_books);
  }

  Future<List<Book>> getBooksByCategory(String category) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (category == 'All') {
      return List.from(_books);
    }
    return _books.where((book) => book.category == category).toList();
  }

  Future<List<Book>> searchBooks(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final lowercaseQuery = query.toLowerCase();
    return _books.where((book) {
      return book.title.toLowerCase().contains(lowercaseQuery) ||
          book.author.toLowerCase().contains(lowercaseQuery) ||
          book.category.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }

  Future<Book?> getBookById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return _books.firstWhere((book) => book.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<bool> addBook(Book book) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      _books.add(book);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateBook(Book updatedBook) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final index = _books.indexWhere((book) => book.id == updatedBook.id);
      if (index != -1) {
        _books[index] = updatedBook;
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteBook(String id) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final index = _books.indexWhere((book) => book.id == id);
      if (index != -1) {
        _books.removeAt(index);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> borrowBook(String bookId, String userId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      final index = _books.indexWhere((book) => book.id == bookId);
      if (index != -1 && _books[index].isAvailable) {
        _books[index] = _books[index].copyWith(
          isAvailable: false,
          borrowedBy: userId,
          borrowedDate: DateTime.now(),
          dueDate: DateTime.now().add(const Duration(days: 14)),
        );
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> returnBook(String bookId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      final index = _books.indexWhere((book) => book.id == bookId);
      if (index != -1 && !_books[index].isAvailable) {
        _books[index] = _books[index].copyWith(
          isAvailable: true,
          borrowedBy: null,
          borrowedDate: null,
          dueDate: null,
        );
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<List<Book>> getBorrowedBooks(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _books.where((book) => book.borrowedBy == userId).toList();
  }

  Future<Map<String, int>> getBookStatistics() async {
    await Future.delayed(const Duration(milliseconds: 200));
    final total = _books.length;
    final available = _books.where((book) => book.isAvailable).length;
    final borrowed = total - available;

    return {'total': total, 'available': available, 'borrowed': borrowed};
  }

  List<String> getCategories() {
    final categories = <String>{'All'};
    for (final book in _books) {
      categories.add(book.category);
    }
    return categories.toList();
  }
}
