/^Author:/ {
   author           = $2 " " $3
   commits[author] += 1
   commits["tot"]  += 1
}

/^[0-9]+ +[0-9]+ +vendor|framework/ { next }

/^[0-9]/ {
   more[author] += $1
   less[author] += $2
   file[author] += 1
   changes[author] += $1 + $2

   more["tot"]  += $1
   less["tot"]  += $2
   file["tot"]  += 1
   changes["tot"] += $1 + $2

}

END {
   for (author in commits) {
      if (author != "tot") {

		relcommits[author] =  commits[author] / commits["tot"] * 100
		relchanges[author] =  changes[author] / changes["tot"] * 100

         printf "%s:\n  lines changed: %.0f (%.0f%%)\n  commits: %.0f (%.0f%%)\n", author, changes[author], relchanges[author], commits[author], relcommits[author]
      }
   }
}