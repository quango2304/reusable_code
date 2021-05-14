
extension ListExtensions<E> on List<E> {
  List<E> get clone => List.from(this);

  bool replace(E element, E replacement) {
    var found = false;
    final len = length;
    for (var i = 0; i < len; i++) {
      if (element == this[i]) {
        this[i] = replacement;
        found = true;
      }
    }
    return found;
  }

  bool replaceWhere(Function(E e) getCondition, E replacement) {
    var found = false;
    final len = length;
    for (var i = 0; i < len; i++) {
      if (getCondition(this[i])) {
        this[i] = replacement;
        found = true;
      }
    }
    return found;
  }

  List<E> removeNull() {
    final newList = <E>[];
    forEach((element) {
      if (element != null) {
        newList.add(element);
      }
    });
    return newList;
  }

  //remove duplicated by a field of object, ex: id, name,...
  //getCondition return type can be String, int, ... except boolean
  List<E> removeDuplicatedBy(Function(E e) getCondition) {
    return {for (var e in this) getCondition(e): e}.values.toList();
  }

  List<E> removeDuplicated() {
    final newList = <E>[];
    forEach((element) {
      if (!newList.contains(element)) {
        newList.add(element);
      }
    });
    return newList;
  }

  E? safeGet(int index) => isEmpty || length <= index ? null : this[index];

  E? get safeGetLast => isEmpty ? null : this[length - 1];

  bool compare(List listB) {
    if (length != listB.length) return false;
    for (var i = 0; i < length; i++) {
      if (this[i] != listB[i]) return false;
    }
    return true;
  }

  bool compareBy(List<E> listB, Function(E e) getCondition) {
    if (length != listB.length) return false;
    for (var i = 0; i < length; i++) {
      if (getCondition(this[i]) != getCondition(listB[i])) return false;
    }
    return true;
  }

  int countItem(E item) {
    var count = 0;
    forEach((element) {
      if (element == item) count++;
    });
    return count;
  }

  List<E> addDistinct(E item) {
    if (!this.contains(item)) {
      this.add(item);
    }
    return this;
  }

  List<E> addAllDistinct(List<E> items) {
    items.forEach((item) {
      if (!this.contains(item)) {
        this.add(item);
      }
    });
    return this;
  }
}

extension ListNumExtension<T> on List<num> {
  num maxElement() {
    var max = elementAt(0);
    forEach((element) {
      if ((element) > max) {
        max = element;
      }
    });
    return max;
  }

  num minElement() {
    var min = elementAt(0);
    forEach((element) {
      if ((element) < min) {
        min = element;
      }
    });
    return min;
  }
}