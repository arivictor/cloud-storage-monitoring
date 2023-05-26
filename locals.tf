locals {
  bucket_paths = { for p in var.bucket_paths : index(var.bucket_paths, p) => p }
}