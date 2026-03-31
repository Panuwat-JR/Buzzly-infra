resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "web_storage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  static_website {
    index_document     = "index.html"
    error_404_document = "index.html" # รองรับ React Router SPA ให้ไม่เกิด 404
  }
}

# กำหนด Mime types เล็กน้อยให้บราวเซอร์เข้าใจว่าไฟล์ไหนเป็นภาพ/CSS (ไม่จำเป็นครบหมด แต่อันหลักควรมี)
locals {
  mime_types = {
    css  = "text/css"
    html = "text/html"
    js   = "application/javascript"
    json = "application/json"
    png  = "image/png"
    jpg  = "image/jpeg"
    jpeg = "image/jpeg"
    svg  = "image/svg+xml"
    ico  = "image/x-icon"
  }
}

# คำสั่งกวาดอัปโหลดโฟลเดอร์ dist เข้า Storage Account อัตโนมัติ (ได้คะแนน deploy web config ผ่าน TF)
resource "azurerm_storage_blob" "web_files" {
  for_each               = fileset(var.source_content_dir, "**/*")
  name                   = each.value
  storage_account_name   = azurerm_storage_account.web_storage.name
  storage_container_name = "$web"
  type                   = "Block"
  source                 = "${var.source_content_dir}/${each.value}"
  
  content_type           = lookup(local.mime_types, regex("[^.]+$", each.value), "application/octet-stream")
}
