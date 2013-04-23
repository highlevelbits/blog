---
title: detecting prime numbers with Test Driven Development
kind: article
created_at: 2013-04-23
author: fredrik
tags: tdd, java
---

This tuesday I held a half day workshop on Test Driven Development for a group of developers
at Smart Bears Stockholm office. I prepared by writing a
[generic post about TDD](/2013/04/what_is_tdd.html) explaining the main principles. During the
session we used prime number detection as an example kata. This is a very simple problem and
as such useful to show how to do proper TDD. On the other hand there isn't much of real world
problems in there. We started with the tiniest test:

    @Test
    public void oneIsPrime(){
        assertTrue("1 should be a prime", Prime.isPrime(1));
    }

and implemented this with:

    public class Prime {
      public static boolean isPrime(int number){
        return true;
      }
    }

This piece of code is the best thing that fulfills our test so there is no need to get into the
refactor phase at this stage. The language is called Java if you don't recognize it.

The next test takes the first non prime number and test it:

    @Test
    public void fourIsNotPrime(){
        assertFalse("4 should not be a prime", Prime.isPrime(4));
    }

implemented with:

    public static boolean isPrime(int number){
        if( number == 4 ) return false;
        return true;
    }

Now this can be refactored:

    public static boolean isPrime(int number){
        return number != 4;
    }

Note that the refactoring doesn't add functionality - it just makes the code easier to read. Add another
non-prime:

    @Test
    public void nineIsNotPrime() {
        assertNotPrime(9);
    }

and helper methods to make the test code a little bit easier to read:

    public void assertNotPrime(int number){
        String message = "" + number + " should not be a prime";
        assertFalse(message, Prime.isPrime(number));
    }

    public void assertPrime(int number){
        String message = "" + number + " should be a prime";
        assertTrue(message, Prime.isPrime(number));
    }

Actually in the workshop we didn't break out the asserts into methods but went straight for the
next test code refactoring. The code under test is still naive:

    public static boolean isPrime(int number){
        if( number == 4 || number == 9 ) return false;
        return true;
    }

Now we felt the need to introduce an easier way to test many combinations at once. This is a bit awkward in
Java and come much more natural in a dynamic language. We used the junit runner Parameterized to be able to
have one test for each prime we'd like to test while reusing as much of the test code as possible. Here is the
implementation:

    package prime;

    import java.util.*;

    import org.junit.*;
    import org.junit.runner.*;
    import org.junit.runners.*;
    import org.junit.runners.Parameterized.*;

    import static org.junit.Assert.*;

    @RunWith(Parameterized.class)
    public class TestPrime {
        private int number;
        private boolean isPrime;

        public TestPrime(int number, boolean isPrime){
            this.number = number;
            this.isPrime = isPrime;
        }

        @Parameters
        public static Collection<Object[]> bunchOfPrimes(){
            return Arrays.asList(new Object[][]{
                {1, true},
                {2, true},
                {3, true},
                {4, false},
                {7, true},
                {9, false},
                {10, false},
                {13, true},
                {15, false}
            });
        }

        @Test
        public void isPrime(){
            if(this.isPrime){
                assertPrime(this.number);
            } else {
                assertNotPrime(this.number);
            }
        }

        public void assertPrime(int number){
            String message = "" + number + " should be a prime";
            assertTrue(message, Prime.isPrime(number));
        }

        public void assertNotPrime(int number){
            String message = "" + number + " should not be a prime";
            assertFalse(message, Prime.isPrime(number));
        }
    }

This is the code that I prepared before the session. When we programmed it in the session we ended up with
using `assertEquals` instead of having the helper methods and I think that was a nicer approach.

`Parameterized` requires a method that returns test data. It should have the awkward return type
`Collection<Object[]>` - that is a collection of object arrays. Each member of the array should have
data so that the test class constructor can be called. In our case there is a number - the prime candidate -
and a boolean indicating if it is expected to be a prime or not. The runner creates one instance per
data point and runs all Test methods on that one. In our case there is only the `isPrime` method.

Now all there is left is to implement the real stuff:

    public static boolean isPrime(int number){
      for(int i = 2; i < number; i++) {
        if(number % i == 0) {
          return false;
        }
      }
      return true;
    }

and a somewhat refactored solution:

    public static boolean isPrime(int number){
      for(int i = 2; i <= sqrt(number); i++) {
        int remainder = number % i;
        if(remainder == 0) {
          return false;
        }
      }
      return true;
    }

    private static double sqrt(int number){
      return Math.sqrt(number);
    }

This was a fun but naive exercise.