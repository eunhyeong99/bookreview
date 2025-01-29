import 'package:bookreview/src/common/model/book_review_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookReviewInfoRepository {
  FirebaseFirestore db;

  BookReviewInfoRepository(this.db);

  Future<void> createBookReviewInfo(BookReviewInfo bookReviewInfo) async {
    await db.collection('book_review_info').add(bookReviewInfo.toJson());
  }

  Future<BookReviewInfo?> loadBookReviewInfo(String bookId) async {
    var doc = await db
        .collection('book_review_info')
        .where(
          'bookId',
          isEqualTo: bookId,
        )
        .get();
    if (doc.docs.isEmpty) {
      return null;
    } else {
      return BookReviewInfo.fromJson(doc.docs.first.data());
    }
  }

  Future<void> updateBookReviewInfo(BookReviewInfo bookReviewInfo) async {
    var data = await db.collection('book_review_info').where('bookId',isEqualTo: bookReviewInfo.bookId).get();
    await db.collection('book_review_info').doc(data.docs.first.id).update(bookReviewInfo.toJson());
  }
}
