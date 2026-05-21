#!/bin/bash
# Download all images for quadrotor-history.md
# Run this script from the repo root: bash download-images.sh
#
# Each image is tried with up to 3 attempts and 5-minute timeout per attempt.
# If Wikimedia is blocked, try a VPN or manually open the ALT_URL in a browser.
# ALT_URLs use images.weserv.nl caching proxy as fallback.

set +e  # don't stop on first error
mkdir -p images
cd images

TIMEOUT="--connect-timeout 30 --max-time 300 --retry 2 --retry-delay 10"
OK=0
FAIL=0

download() {
    local name="$1"; shift
    echo "[$name]"
    curl -L $TIMEOUT -o "$name" "$1" 2>&1 | tail -1
    if [ -s "$name" ] && [ "$(wc -c < "$name")" -gt 5000 ]; then
        echo "  => OK ($(wc -c < "$name") bytes)"
        OK=$((OK+1))
    else
        echo "  => FAILED, trying alt URL..."
        rm -f "$name"
        curl -L $TIMEOUT -o "$name" "$2" 2>&1 | tail -1
        if [ -s "$name" ] && [ "$(wc -c < "$name")" -gt 5000 ]; then
            echo "  => OK via alt ($(wc -c < "$name") bytes)"
            OK=$((OK+1))
        else
            echo "  => FAILED. Open in browser: $1"
            rm -f "$name"
            FAIL=$((FAIL+1))
        fi
    fi
    echo ""
}

echo "Downloading 8 images... (5 min timeout each, 2 retries)"
echo "If stuck, use Ctrl+C and open browser URLs manually."
echo "========================================================================"
echo ""

# 1. Breguet-Richet Gyroplane No.1 (1907)
# Direct upload.wikimedia.org URL
download "breguet-gyroplane-1907.jpg" \
  "https://upload.wikimedia.org/wikipedia/commons/d/d3/Breguet_Gyroplane_1907.jpg" \
  "https://images.weserv.nl/?url=upload.wikimedia.org/wikipedia/commons/d/d3/Breguet_Gyroplane_1907.jpg&w=1200"

# 2. Oehmichen No.2 (1923-1924) — on English Wikipedia
download "oehmichen-no2-1924.jpg" \
  "https://upload.wikimedia.org/wikipedia/en/6/6e/Oemichen2.jpg" \
  "https://images.weserv.nl/?url=upload.wikimedia.org/wikipedia/en/6/6e/Oemichen2.jpg&w=1200"

# 3. de Bothezat Flying Octopus (1922)
download "debothezat-flying-octopus-1922.jpg" \
  "https://upload.wikimedia.org/wikipedia/commons/6/68/Helicopter%20designed%20by%20George%20de%20Bothezat%2C%20in%20flight%20at%20McCook%20field.%20%2838d278b9-0a37-4286-8575-7b1b16f66d19%29.jpg" \
  "https://images.weserv.nl/?url=upload.wikimedia.org/wikipedia/commons/6/68/Helicopter%20designed%20by%20George%20de%20Bothezat%2C%20in%20flight%20at%20McCook%20field.%20%2838d278b9-0a37-4286-8575-7b1b16f66d19%29.jpg&w=1200"

# 4. Parrot AR.Drone 2.0
download "parrot-ardrone-2.jpg" \
  "https://upload.wikimedia.org/wikipedia/commons/5/52/Parrot_AR.Drone_2.JPG" \
  "https://images.weserv.nl/?url=upload.wikimedia.org/wikipedia/commons/5/52/Parrot_AR.Drone_2.JPG&w=1200"

# 5. MPU-6050 MEMS IMU
download "mpu6050-imu.jpg" \
  "https://upload.wikimedia.org/wikipedia/commons/c/c9/InvenSense_MPU-6050_6-axis_gyroscope_and_accelerometer_module%2C_MPU-6050.jpg" \
  "https://images.weserv.nl/?url=upload.wikimedia.org/wikipedia/commons/c/c9/InvenSense_MPU-6050_6-axis_gyroscope_and_accelerometer_module%2C_MPU-6050.jpg&w=1200"

# 6. DJI Phantom 3 Advanced
download "dji-phantom3.jpg" \
  "https://upload.wikimedia.org/wikipedia/commons/b/b8/2015_Dron_DJI_Phantom_3_Advanced.JPG" \
  "https://images.weserv.nl/?url=upload.wikimedia.org/wikipedia/commons/b/b8/2015_Dron_DJI_Phantom_3_Advanced.JPG&w=1200"

# 7. DJI Mavic Pro
download "dji-mavic-pro.jpg" \
  "https://upload.wikimedia.org/wikipedia/commons/e/e9/DJI_MavicPro.jpg" \
  "https://images.weserv.nl/?url=upload.wikimedia.org/wikipedia/commons/e/e9/DJI_MavicPro.jpg&w=1200"

# 8. Shuo Yang et al. SO(3) control experiment figure (ICRA 2015)
download "shuo-yang-so3-control-2015.jpg" \
  "https://figures.semanticscholar.org/a341e2975a0bd9e5e4c9f224289bf7e73fd1964a/figure-4.jpg" \
  "https://figures.semanticscholar.org/a341e2975a0bd9e5e4c9f224289bf7e73fd1964a/figure-4.jpg"

echo "========================================================================"
echo "Results: $OK downloaded, $FAIL failed"
ls -lh *.jpg 2>/dev/null
echo ""
if [ $FAIL -gt 0 ]; then
    echo "Some images failed. Options:"
    echo "  1. Use a VPN and re-run this script"
    echo "  2. Open the 'FAILED' URLs above in a browser and save to images/"
    echo "  3. Search for the image by name and download manually"
fi
