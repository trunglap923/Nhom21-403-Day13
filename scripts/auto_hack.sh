#!/bin/bash

# Đảm bảo tắt mọi lỗi có sẵn trước khi bắt đầu
python scripts/inject_incident.py --scenario rag_slow --disable
python scripts/inject_incident.py --scenario tool_fail --disable

echo "🟩 BƯỚC 1: Khởi động - Bắn traffic sạch (Xanh mượt)"
python scripts/load_test.py --concurrency 5
sleep 4

echo "🟩 BƯỚC 2: Bắn thêm lứa traffic sạch nữa để ổn định đường cơ sở"
python scripts/load_test.py --concurrency 5
sleep 4

echo "🚨 BƯỚC 3: TIÊM VIRUS (Làm chậm hệ thống + Gây lỗi)"
python scripts/inject_incident.py --scenario rag_slow
python scripts/inject_incident.py --scenario tool_fail
sleep 2

echo "🟥 BƯỚC 4: Bắn traffic vô hệ thống đang nhiễm bệnh..."
python scripts/load_test.py --concurrency 5
sleep 4

echo "🟥 BƯỚC 5: Nhồi đòn ân huệ để bung bét Dashboard..."
python scripts/load_test.py --concurrency 5

echo "✅ HOÀN TẤT. HÃY CHỤP LẠI MÀN HÌNH DASHBOARD NGAY BÂY GIỜ!"
