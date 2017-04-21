#/bin/sh

echo "{\"cmd-param\":\"-e -k 'MIIEpQIBAAKCAQEA5ANvIDDY1a+6bEb8LjW6e9HdcFIung' -b BYE --disable-compile\",\"COCOS_CONSOLE_ROOT\":\""$COCOS_CONSOLE_ROOT"\"}">jsonmaker.config

rm -rf erc
mkdir erc
cp -r src erc/src
cocos luacompile -s erc/src -d erc/src -e -k "MIIEpQIBAAKCAQEA5ANvIDDY1a+6bEb8LjW6e9HdcFIung" -b BYE --disable-compile
cd erc
find . -name "*.lua" -exec rm -rf {} \;
rm -rf ../res/src.zip
zip -r ../res/src.zip src
