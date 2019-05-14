#!/bin/bash

set -e
set -u
set -o pipefail

echo "~~~ Traditional JDK (absence of the JVMCI Compiler) ~~~"
$(java Streams 100000 200 &> /tmp/traditional.out)
grep TOTAL /tmp/traditional.out

echo "~~~ GraalVM (with the JVMCI Compiler disabled) ~~~"
$($GRAALVM_HOME/bin/java -XX:-UseJVMCICompiler Streams 100000 200 &> /tmp/jvmci_disabled.out)
grep TOTAL /tmp/jvmci_disabled.out

echo "~~~ GraalVM (with the JVMCI Compiler enabled) ~~~"
$($GRAALVM_HOME/bin/java -XX:+UseJVMCICompiler Streams 100000 200 &> /tmp/jvmci_enabled.out)
grep TOTAL /tmp/jvmci_enabled.out