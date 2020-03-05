# The program checks the hash and displays those months
# for which the number of days is exactly 30
hash = { January: 31, February: 29, March: 31,
         April: 30, May: 31, June: 30,
         July: 31, August: 31, September: 30,
         October: 31, November: 30, December: 31 }
hash.each { |month, day| puts month if day == 30 }
