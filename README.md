# leo_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
## 📚 Tổng hợp cách tạo Provider bằng Riverpod Generator

|Mục tiêu|Cách viết|Provider sinh ra|Ghi chú|
|---|---|---|---|
|✅ **FutureProvider**|`@riverpod Future<T> name(NameRef ref) {}`|`nameProvider`|Dùng cho async 1 lần|
|✅ **StreamProvider**|`@riverpod Stream<T> name(NameRef ref) {}`|`nameProvider`|Dùng để nghe stream (ví dụ authState)|
|✅ **StateProvider**|`@riverpod T name(NameRef ref) {}`|`nameProvider`|Dùng khi chỉ cần thay đổi giá trị đơn giản|
|✅ **StateNotifierProvider**|`@riverpod class Name extends _$Name {}`|`nameProvider`|Dùng cho logic có trạng thái phức tạp|
|✅ **NotifierProvider (sync)**|`@riverpod class Name extends _$Name {}` với `build()` trả về trạng thái ban đầu|`nameProvider`|Không async, không cần `StateNotifier`|
