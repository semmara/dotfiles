enc.aes256 () {
	if [ $# -lt 1 ]; then
		echo "Usage: $0 filename"
		exit 1
	fi
	openssl enc -e -aes256 -in "$1" -out "$1".enc
}

dec.aes256 () {
	if [ $# -lt 2 ]; then
		echo "Usage: $0 encrypted_file decrypted_file"
		exit 1
	fi
	openssl enc -d -aes256 -in "$1" -out "$2"
}
