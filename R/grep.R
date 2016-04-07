#' @title Overriding grep from base package
#' @export
#' @description Overrides the grep function to be amenable to using pipe
#' operators.  The documentation below comes from the help file for base::grep
#'
#' grep, grepl, regexpr, gregexpr and regexec search for matches to
#' argument pattern within each element of a character vector: they differ in
#' the format of and amount of detail in the results.
#'
#' sub and gsub perform replacement of the first and all matches respectively.
#' @param pattern character string containing a regular expression (or
#' character string for fixed = TRUE) to be matched in the given character
#' vector. Coerced by as.character to a character string if possible. If a
#' character vector of length 2 or more is supplied, the first element is used
#' with a warning. Missing values are allowed except for regexpr and gregexpr.
#' @param x a character vector where matches are sought, or an object
#' which can be coerced by as.character to a character vector. Long vectors are
#' supported.
#' @param ignore.case if FALSE, the pattern matching is case sensitive and if
#' TRUE, case is ignored during matching.
#' @param perl logical. Should Perl-compatible regexps be used?
#' @param value if FALSE, a vector containing the (integer) indices of the
#' matches determined by grep is returned, and if TRUE, a vector containing the
#' matching elements themselves is returned.
#' @param fixed logical. If TRUE, pattern is a string to be matched as is.
#' Overrides all conflicting arguments.
#' @param useBytes logical. If TRUE the matching is done byte-by-byte rather
#' than character-by-character
#' @param invert logical. If TRUE return indices or values for elements that do
#' not match.
#' @name grep
#' @section Details:
#' Arguments which should be character strings or character vectors are coerced to character if possible.
#'
#' Each of these functions (apart from regexec, which currently does not support Perl-style regular expressions) operates in one of three modes:
#'
#'   1. fixed = TRUE: use exact matching.
#'
#' 	 2. perl = TRUE: use Perl-style regular expressions.
#'
#'   3. fixed = FALSE, perl = FALSE: use POSIX 1003.2 extended regular expressions.
#'
#' See the help pages on regular expression for details of the different types of regular expressions.
#'
#' The two *sub functions differ only in that sub replaces only the first occurrence of a pattern whereas gsub replaces all occurrences. If replacement contains backreferences which are not defined in pattern the result is undefined (but most often the backreference is taken to be "").
#'
#' For regexpr, gregexpr and regexec it is an error for pattern to be NA, otherwise NA is permitted and gives an NA match.
#'
#' The main effect of useBytes is to avoid errors/warnings about invalid inputs and spurious matches in multibyte locales, but for regexpr it changes the interpretation of the output. It inhibits the conversion of inputs with marked encodings, and is forced if any input is found which is marked as "bytes" see Encoding).
#'
#' Caseless matching does not make much sense for bytes in a multibyte locale, and you should expect it only to work for ASCII characters if useBytes = TRUE.
#'
#' regexpr and gregexpr with perl = TRUE allow Python-style named captures, but not for long vector inputs.
#'
#' Invalid inputs in the current locale are warned about up to 5 times.
#'
#' Caseless matching with PERL = TRUE for non-ASCII characters depends on the PCRE library being compiled with 'Unicode property support': an external library might not be.
#'
#' @section Value:
#' grep(value = FALSE) returns a vector of the indices of the elements of x that yielded a match (or not, for invert = TRUE. This will be an
#' integer vector unless the input is a long vector, when it will be a double vector.
#'
#' grep(value = TRUE) returns a character vector containing the selected elements of x (after coercion, preserving names but no other attributes).
#'
#' grepl returns a logical vector (match or not for each element of x).
#'
#' For sub and gsub return a character vector of the same length and with the same attributes as x (after possible coercion to character).
#' Elements of character vectors x which are not substituted will be returned unchanged (including any declared encoding). If useBytes =
#' FALSE a non-ASCII substituted result will often be in UTF-8 with a marked encoding (e.g., if there is a UTF-8 input, and in a multibyte
#' locale unless fixed = TRUE). Such strings can be re-encoded by enc2native.
#'
#' regexpr returns an integer vector of the same length as text giving the starting position of the first match or -1 if there is none, with
#' attribute "match.length", an integer vector giving the length of the matched text (or -1 for no match). The match positions and lengths are
#' in characters unless useBytes = TRUE is used, when they are in bytes. If named capture is used there are further attributes "capture.start",
#' "capture.length" and "capture.names".
#'
#' gregexpr returns a list of the same length as text each element of which is of the same form as the return value for regexpr, except that the starting positions of every (disjoint) match are given.
#'
#' regexec returns a list of the same length as text each element of which is either -1 if there is no match, or a sequence of integers with the starting positions of the match and all substrings corresponding to parenthesized subexpressions of pattern, with attribute "match.length" a vector giving the lengths of the matches (or -1 for no match).
#'
#' @section Warning:
#' POSIX 1003.2 mode of gsub and gregexpr does not work correctly with repeated word-boundaries (e.g., pattern = "\\b"). Use perl = TRUE for such matches (but that may not work as expected with non-ASCII inputs, as the meaning of 'word' is system-dependent).
#'
#' @section Performance considerations:
#' If you are doing a lot of regular expression matching, including on very long strings, you will want to consider the options used. Generally PCRE will be faster than the default regular expression engine, and fixed = TRUE faster still (especially when each pattern is matched only a few times).
#'
#' If you are working in a single-byte locale and have marked UTF-8 strings that are representable in that locale, convert them first as just one UTF-8 string will force all the matching to be done in Unicode, which attracts a penalty of around 3x for the default POSIX 1003.2 mode.
#'
#' If you can make use of useBytes = TRUE, the strings will not be checked before matching, and the actual matching will be faster. Often byte-based matching suffices in a UTF-8 locale since byte patterns of one character never match part of another.
#'
#' @section Source:
#' The C code for POSIX-style regular expression matching has changed over the years. As from R 2.10.0 the TRE library of Ville Laurikari (http://laurikari.net/tre/) is used. The POSIX standard does give some room for interpretation, especially in the handling of invalid regular expressions and the collation of character ranges, so the results will have changed slightly over the years.
#'
#' For Perl-style matching PCRE (http://www.pcre.org) is used.
#'

grep <- function(x, pattern, ignore.case = FALSE, perl = FALSE, value = FALSE,
				 fixed = FALSE, useBytes = FALSE, invert = FALSE) {

	grep(pattern = pattern, x = x, ignore.case = ignore.case, perl = perl,
		 value = value, fixed = fixed, useBytes = useBytes, invert = invert)

}


#' @name grepl
#' @export
#' @rdname grep
#'

grepl <- function(x, pattern, ignore.case = FALSE, perl = FALSE, fixed = FALSE,
				  useBytes = FALSE) {

	grepl(pattern = pattern, x = x, ignore.case = ignore.case, perl = perl,
		  fixed = fixed, useBytes = useBytes)

}


#' @param replacement a replacement for matched pattern in sub and gsub. Coerced
#' to character if possible. For fixed = FALSE this can include backreferences
#' "\\1" to "\\9" to parenthesized subexpressions of pattern. For perl = TRUE
#' only, it can also contain "\\U" or "\\L" to convert the rest of the replacement
#' to upper or lower case and "\\E" to end case conversion. If a character vector
#' of length 2 or more is supplied, the first element is used with a warning.
#' If NA, all elements in the result corresponding to matches will be set to NA.
#' @name sub
#' @export
#' @rdname grep
#'

sub <- function(x, pattern, replacement, ignore.case = FALSE, perl = FALSE,
				fixed = FALSE, useBytes = FALSE) {

	sub(pattern = pattern, replacement = replacement, x = x,
		ignore.case = ignore.case, perl = FALSE, fixed = fixed,
		useBytes = useBytes)

}

#' @name gsub
#' @export
#' @rdname grep
#'

gsub <- function(x, pattern, replacement, ignore.case = FALSE, perl = FALSE,
				 fixed = FALSE, useBytes = FALSE) {

	gsub(pattern = pattern, replacement = replacement, x = x,
		 ignore.case = ignore.case, perl = perl,
		 fixed = fixed, useBytes = useBytes)

}


#' @param text a character vector where matches are sought, or an object
#' which can be coerced by as.character to a character vector. Long vectors are
#' supported.
#' @name regexpr
#' @export
#' @rdname grep
#'

regexpr <- function(text, pattern, ignore.case = FALSE, perl = FALSE,
					fixed = FALSE, useBytes = FALSE) {

	regexpr(pattern = pattern, text = text, ignore.case = ignore.case,
			perl = perl, fixed = fixed, useBytes = useBytes)

}

#' @name gregexpr
#' @export
#' @rdname grep
#'

gregexpr <- function(text, pattern, ignore.case = FALSE, perl = FALSE,
					 fixed = FALSE, useBytes = FALSE) {

	gregexpr(pattern = pattern, text = text, ignore.case = ignore.case,
			 perl = perl, fixed = fixed, useBytes = useBytes)

}

#' @name regexec
#' @export
#' @rdname grep
#'

regexec <- function(text, pattern, ignore.case = FALSE, fixed = FALSE,
					useBytes = FALSE) {

	regexec(pattern = pattern, text = text, ignore.case = ignore.case,
			fixed = fixed, useBytes = useBytes)

} # End of regexec override
