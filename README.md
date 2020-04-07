# PrettySHAConverter

PrettySHAConverter является результатом выполнения лабораторной работы по дисциплине "Информационная Безопасность".  
ПО демонстрирует вычисление констрольной суммы в виде [SHA-1](https://ru.wikipedia.org/wiki/SHA-1) хеша предоставленного изображения.

## Зависимости

Необходимая версия ЯП Ruby содержится в файле `.ruby-version`.  
В качестве инструкций по установке можно использовать данную [документацию](https://www.ruby-lang.org/ru/documentation/installation/).  
Программа использует [bundler](https://bundler.io/) версии 2.0.2 для управлением зависимостями.  
Установка:
```bash
gem install bundler -v 2.0.2
```
Список зависимостей описан в `Gemfile`  
Для установки всех библиотек необходимо выполнить:
```bash
bundle install
```

## Использование
PrettySHAConverter предоставляет удобный [CLI](https://ru.wikipedia.org/wiki/CLI)  

Список команд можно посмотреть с помощью флага `--help`
```bash
$ bundle exec ruby pretty_sha1_converter.rb --help
```

Флаг `--help` также можно указать для получение справки по конкретной команде, пример:
```bash
$ bundle exec ruby pretty_sha1_converter.rb version --help
```

#### Генерация и сравнение хеш строки 
Генерацию хеш строки можно осуществить с помощью команды `generate` (также `g -g --generate`).  
В качестве обязательного аргумента выступает строка для преобразования.
Выходной хеш выводится пользователю в STDOUT.

```bash
$ bundle exec ruby pretty_sha1_converter.rb generate --help
Command:
  pretty_sha1_converter.rb generate
  
Usage:
  pretty_sha1_converter.rb generate STRING
  
Description:
  Генерирует SHA-1 хеш введённой строки и выводит на экран
  
Arguments:
  STRING                # REQUIRED Строка
  
Options:
  --help, -h            # Print this help
```

Пример использования:
```bash
$ bundle exec ruby pretty_sha1_converter.rb generate "Hello World"
Хеш - 0a4d55a8d778e5022fab701977c5d840bbc486d0
```

Сравнение хеш-строки с введённой можно произвестви с помощтю команды `compare` (также `--compare`)
В качестве обязательных аргументов выступают необходимая строка и SHA-1 хеш.
Результат сравнение выводится пользователю в STDOUT.

```bash
$ bundle exec ruby pretty_sha1_converter.rb compare --help
Command:
  pretty_sha1_converter.rb compare

Usage:
  pretty_sha1_converter.rb compare STRING HASH

Description:
  Сравнивает SHA-1 хеш и введённую строку

Arguments:
  STRING                # REQUIRED Строка
  HASH                  # REQUIRED Хеш

Options:
  --help, -h            # Print this help
```

Пример использования:
```bash
$ bundle exec ruby pretty_sha1_converter.rb compare "Hello World" "SIMPLE_HASH"
Хеш не соответствует введённой строке
```

#### Высчисление контрольной суммы изображения
Данную функцию реализует команда `convert` (также `--convert`).  
Она требует путь до картинки.
Результат вычисления выводится пользователю в STDOUT.

```bash
$ bundle exec ruby pretty_sha1_converter.rb convert --help
Command:
  pretty_sha1_converter.rb convert

Usage:
  pretty_sha1_converter.rb convert PICTURE

Description:
  Конвертирует изображение (.jpg .jpeg .png) в SHA-1 хеш

Arguments:
  PICTURE               # REQUIRED Путь до картинки

Options:
  --help, -h            # Print this help
```

Пример использования:
```bash
$ bundle exec ruby pretty_sha1_converter.rb convert "/path/to/picture.jpg" 
Хеш строка картинки - f84efb620744db1c422800669c4fcb852e03998d
```

## TODO
1) Написать системные и юнит тесты.
2) Вынести классы и модули в отдельные файлы, создать единую точку входа с подгрузкой всех зависимостей.
3) Обработать поведение при возникновении дополнительных неожиданных исключений.

## Содействие
Пользование PrettySHAConverter покрывается лицензией [MIT](https://ru.wikipedia.org/wiki/%D0%9B%D0%B8%D1%86%D0%B5%D0%BD%D0%B7%D0%B8%D1%8F_MIT). Вы можете использовать исходный код программы под собственным авторским именем только после оформления и последующего утверждения мною PR с изменениями, которые затрагивают работу внутренних алгоритмов программы, влияют на структуру и итоговую производительность кода. Идеи для PR можно взять, например, из блока **TODO**.
