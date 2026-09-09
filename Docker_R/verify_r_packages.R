args <- commandArgs(trailingOnly = TRUE)

if (length(args) == 0L) {
    stop("Usage: Rscript verify_r_packages.R <package> [<package> ...]", call. = FALSE)
}

failed <- args[!vapply(args, requireNamespace, logical(1), quietly = TRUE)]

if (length(failed) > 0L) {
    # 「なぜ読み込めないか」を出さないとビルドログから原因を追えないため、理由を添える
    reasons <- vapply(failed, function(pkg) {
        msg <- tryCatch({
            loadNamespace(pkg)
            "unknown reason"
        }, error = conditionMessage)
        sprintf("%s: %s", pkg, msg)
    }, character(1))
    stop(
        sprintf("Missing R packages:\n  %s", paste(reasons, collapse = "\n  ")),
        call. = FALSE
    )
}

message(sprintf("Verified %d R packages: %s", length(args), paste(args, collapse = ", ")))
