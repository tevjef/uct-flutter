flutter -v build apk --release

### BEGIN MODIFICATIONS

# Copy mergeJniLibs to debugSymbols
cp -R ./build/app/intermediates/transforms/mergeJniLibs/release/0/lib debugSymbols

# The libflutter.so here is the same as in the artifacts.zip found with symbols.zip
cd debugSymbols/armeabi-v7a

# Download the corresponding libflutter.so with debug symbols
ENGINE_VERSION=`cat $HOME/Desktop/Development/flutter/bin/internal/engine.version`
gsutil cp gs://flutter_infra/flutter/${ENGINE_VERSION}/android-arm-release/symbols.zip .

cd ../../
# The libflutter.so here is the same as in the artifacts.zip found with symbols.zip
cd debugSymbols/arm64-v8a
gsutil cp gs://flutter_infra/flutter/${ENGINE_VERSION}/android-arm64-release/symbols.zip .

# Replace libflutter.so
unzip -o symbols.zip
rm -rf symbols.zip

# Upload symbols to Crashlytics
cd ../../android
./gradlew crashlyticsUploadSymbolsRelease