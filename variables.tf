variable "location" {
  description = "The Azure Region in which all resources should be created."
  default     = "Southeast Asia"
}

variable "resource_group_name" {
  description = "The name of the Resource Group."
  default     = "ipbuzzly-rg"
}

variable "storage_account_name" {
  description = "The name of the Storage Account (Must be globally unique, lowercase, no symbols)."
  default     = "ipbuzzlystorage"  # เปลี่ยนชื่อตรงนี้หากตอนรันแจ้งว่าซ้ำ
}

variable "source_content_dir" {
  description = "Path to the dist directory of the React/Vite app"
  default     = "../BuzzlyDev/dist" # ทางผ่านอ้างอิงกลับไปยังโฟลเดอร์โปรเจค Web
}
