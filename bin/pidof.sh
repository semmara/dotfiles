#!/bin/sh
ps axc|awk "{if (\$5==\"$1\") print \$1}";
