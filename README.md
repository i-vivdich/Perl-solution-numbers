# Perl-solution-numbers

Perl solution for the test assignment provided by PortaOne
as a part of the 'Become a Developer' course attendants selection.

Returns values of min, max, median, average for the given file (-file), if possible.

## Content

* [Getting Started](#Getting-Started)
* [Prerequisites](#Prerequisites)
* [Working with the script](#Working with the script)
  - [General use-case](#General use-case)
  - [How to run](#How to run)
  - [Sample output](#Sample output)
  - [Run the script with the delimiter pattern being written explicitly](#Run the script with the delimiter pattern being written explicitly)
  - [Other flags](#Other flags)
* [Solution description](#Solution description)
	- [Parsing the cli arguments and displaying man/help pages](#Parsing the cli arguments and displaying man/help pages)
	- [Processing a file](#Processing a file)
	- [Calculating values](#Calculating values)
* [Benchmarking](#Benchmarking)
* [Author](#Author)
* [License](#License)

## Getting Started

Feel free to clone repository in order to start working with it

```
git clone https://github.com/i-vivdich/Perl-solution-numbers.git
```

### Prerequisites

Please keep in mind that **'ActivePerl 5.26.3 Build 2603 (64-bit)'** was used while developing this project.

Next modules are used in script 'perl_solution.pl', so you would have to install them via your favourite package manager.

* [List::MoreUtils](https://metacpan.org/pod/List::MoreUtils) - for minmax method
* [File::Map](https://metacpan.org/pod/File::Map) - for memory maping the file
* [Pod::Usage](https://metacpan.org/pod/Pod::Usage) - for fancy man & help pages
* [Getopt::Long](https://metacpan.org/pod/Getopt::Long) - for managing CLI

### Working with the script

## General use-case

```
perl_solution [-help|-man] -file [-delimiter]
```

## How to run

Next command line will run the script having the value of the 'file' argument as a name of the file which should be processed.

```
perl_solution.pl -f=name_of_the_file.txt
```

## Sample output

```
+--------------------------+
|          RESULTS         |
+--------------------------+
  MAX => | 49999978
+--------------------------+
  MIN => | -4999996
+--------------------------+
  MED => | 25216
+--------------------------+
  AVG => | 7364.41844264184
+--------------------------+
  TIME => | 20 seconds
+--------------------------+
```

## Run the script with the delimiter pattern being written explicitly

By default, the next delimiter pattern is used - any kind of space including newlines and tabs (regular expression /\s+/).

You could specify your own pattern by supplying regexp expression with a '-d' flag.
Use with caution! Example: if you want a pattern to be '/\s+/', then you should write: 'd=\s+'.

```
perl_solution.pl -f=name_of_the_file.txt -d=\s+
```

## Other flags

Next two flags can be also be used (separately): man and help. Man prints out extensive description of the project (just like this README.md), while help print out shorter version of the man.

### Solution description

## Parsing the cli arguments and displaying man/help pages

For the aformentioned task, modules *[Pod::Usage]*, *[Getopt::Long]* were used. Exception-handling in case file is not submitted or arguments is in place.

You can refer to the section 'START CLI processing' in the script for this part of the project.

## Processing a file

As a file is considerably large, it's not efficient enough to slurp the file or even read it line by line. To solve this problem, next approach was used: using module *[File::Map]* the whole file memory maps into the single string variable and then it's gotten parsed by the default or specified delimiter into the array.

## Calculating values

Min/max values were found using module *[List::MoreUtils]* which uses slightly more optimized algorithm than just comparing every value with each other. The boost is around 5 seconds.

Average was found just by simply getting the sum of the array and diving it by the length of the array.

Median was found by sorting the original array.

### Benchmarking

Taking into account that the tests may vary from computer to computer and that benchmarking was done in a pretty dirty manner (not all processes were shut down, only ~10 tests, target machine uses HDD, 2Gb RAM, 2006 y. processor), the result is:

**On average, it takes ~20 sec to compute all the values.**

## Author

* **Igor Vivdich** - *2019*

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
