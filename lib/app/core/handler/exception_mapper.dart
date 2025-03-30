abstract interface class ExceptionMapper {
  Exception? mapException(Exception e, StackTrace stackTrace);
}
