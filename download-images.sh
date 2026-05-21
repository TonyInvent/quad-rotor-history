#!/bin/bash
# Download all images for quadrotor-history.md
# Run this script from the repo root: bash download-images.sh

set -e
mkdir -p images
cd images

echo "Downloading historical quadrotor images..."

# 1. Breguet-Richet Gyroplane No.1 (1907)
echo "[1/8] Breguet-Richet Gyroplane..."
curl -L -o "breguet-gyroplane-1907.jpg" \
  "https://commons.wikimedia.org/wiki/Special:FilePath/Breguet_Gyroplane_1907.jpg?width=1200"

# 2. Oehmichen No.2 (1923-1924)
echo "[2/8] Oehmichen No.2..."
curl -L -o "oehmichen-no2-1924.jpg" \
  "https://en.wikipedia.org/wiki/Special:FilePath/Oemichen2.jpg"

# 3. de Bothezat Flying Octopus (1922)
echo "[3/8] de Bothezat Flying Octopus..."
curl -L -o "debothezat-flying-octopus-1922.jpg" \
  "https://commons.wikimedia.org/wiki/Special:FilePath/Helicopter%20designed%20by%20George%20de%20Bothezat%2C%20in%20flight%20at%20McCook%20field.%20%2838d278b9-0a37-4286-8575-7b1b16f66d19%29.jpg"

# 4. Parrot AR.Drone 2.0
echo "[4/8] Parrot AR.Drone..."
curl -L -o "parrot-ardrone-2.jpg" \
  "https://commons.wikimedia.org/wiki/Special:FilePath/Parrot_AR.Drone_2.JPG?width=1200"

# 5. MPU-6050 MEMS IMU
echo "[5/8] MPU-6050 MEMS IMU..."
curl -L -o "mpu6050-imu.jpg" \
  "https://upload.wikimedia.org/wikipedia/commons/c/c9/InvenSense_MPU-6050_6-axis_gyroscope_and_accelerometer_module%2C_MPU-6050.jpg"

# 6. DJI Phantom 3 Advanced
echo "[6/8] DJI Phantom 3..."
curl -L -o "dji-phantom3.jpg" \
  "https://commons.wikimedia.org/wiki/Special:FilePath/2015_Dron_DJI_Phantom_3_Advanced.JPG?width=1200"

# 7. DJI Mavic Pro
echo "[7/8] DJI Mavic Pro..."
curl -L -o "dji-mavic-pro.jpg" \
  "https://commons.wikimedia.org/wiki/Special:FilePath/DJI_MavicPro.jpg?width=1200"

# 8. Shuo Yang et al. — SO(3) control experiment figure (ICRA 2015)
echo "[8/8] Shuo Yang SO(3) paper figure..."
curl -L -o "shuo-yang-so3-control-2015.jpg" \
  "https://figures.semanticscholar.org/a341e2975a0bd9e5e4c9f224289bf7e73fd1964a/figure-4.jpg"

echo ""
echo "Done! Check images/ directory. File sizes:"
ls -lh *.jpg 2>/dev/null || echo "Some files may have failed — check URLs."
