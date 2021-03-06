#! /bin/bash -ex


rm -rf target/*
mkdir -p target/classes target/test-classes

# Compile main classes into module 'example.a'
javac -d target/classes $(find src/main/java/example.a -name '*.java')


# Compile test classes, also into module 'example.a'
# Adds an extra module used only by the tests
# These can access non-exported packages from above, and package protected classes.
javac --add-modules=java.xml                               \
      --add-reads example.a=java.xml                       \
      -d target/test-classes                               \
      --patch-module example.a=src/test/java/example.a     \
      --module-path=target/classes                         \
      $(find src/test/java/example.a -name '*.java')

# Run a class from target/classes
#
java  --module-path target/classes                           \
      --module example.a/example.a.MainRun


[[ -f "target/test-classes/example/a/Test.class" ]] || (echo "Test.class absent"; exit 1)

# Run a class from target/test-classes
#
java  --add-modules=java.xml                                 \
      --add-reads example.a=java.xml                         \
      --module-path target/classes                           \
      --patch-module example.a=target/test-classes           \
      --module example.a/example.a.Test
