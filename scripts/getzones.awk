@include "config/exclude-regexp-dist.awk"

# Skipping empty strings
(!$1) {next}

# Exclude some domains
(/duckdns/) {next}
(/\.r\.cloudfront\.net/) {next}

# Skipping IP addresses
(/^([0-9]{1,3}\.){3}[0-9]{1,3}$/) {next}

# Removing leading "www."
{sub(/^www\./, "", $1)}

# Removing ending dot
{sub(/\.$/, "", $1)}

{
 if (/\.(ru|co|cu|com|info|net|org|gov|edu|int|mil|biz|pp|ne|msk|spb|nnov|od|in|ho|cc|dn|i|tut|v|dp|sl|ddns|dyndns|livejournal|herokuapp|azurewebsites|cloudfront|ucoz|3dn|nov|linode|sl-reverse|kiev|beget|kirov|akadns|scaleway|fastly|hldns|appspot|my1|hwcdn|deviantart|wixmp|wix|netdna-ssl|brightcove|berlogovo|edgecastcdn|trafficmanager|pximg|github|hopto|u-stream|google|keenetic|eu|googleusercontent|3nx|itch|notion|maryno|vercel|pythonanywhere|force|tilda|ggpht|iboards|mybb2|h1n|bdsmlr|narod|sb-cd|4chan|nichost|cv)\.[^.]+$/)
  {$1 = gensub(/(.+)\.([^.]+\.[^.]+\.[^.]+$)/, "\\2", 1)}
 else
  {$1 = gensub(/(.+)\.([^.]+\.[^.]+$)/, "\\2", 1)}
}

# Sorting domains
{d_other[$1] = $1}

function printarray(arrname, arr) {
    for (i in arr) {
        print i
    }
}

# Final function
END {
    printarray("d_other", d_other)
}
