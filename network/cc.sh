CC_SRC_PATH=github.com/sacc
CHANNEL_NAME=mychannel
CCNAME=sacc
Version=1.0


docker exec cli peer chaincode install -n $CCNAME -v 1.0 -p ${CC_SRC_PATH}

#docker exec -e "CORE_PEER_ADDRESS=peer1.org1.example.com:7051" cli_org1 peer chaincode install -n $CCNAME -v 1.0 -p ${CC_SRC_PATH}

docker exec cli peer chaincode instantiate -o orderer.example.com:7050 -C $CHANNEL_NAME -n $CCNAME -v 1.0 -c '{"Args":["a","100"]}' -P "OR ('Org1MSP.member','Org2MSP.member','Org3MSP.member')"
sleep 5

docker exec cli peer chaincode query -C $CHANNEL_NAME -n $CCNAME -c '{"Args":["get","a"]}' 

docker exec cli peer chaincode invoke -C $CHANNEL_NAME -n $CCNAME -c '{"Args":["set","b","200"]}' 

sleep 5

docker exec cli peer chaincode query -C $CHANNEL_NAME -n $CCNAME -c '{"Args":["get","b"]}' 
