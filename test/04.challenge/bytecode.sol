pragma solidity 0.8.13;
bytes constant BYTECODE = hex"608060405260008060146101000a81548160ff02191690831515021790555060008060156101000a81548160ff02191690831515021790555034801561004457600080fd5b50613533806100546000396000f3fe6080604052600436106100705760003560e01c8063b8d34cde1161004e578063b8d34cde1461024a578063d8cb06d214610279578063e1c7392a14610283578063f28adc4d1461029a57610070565b806302718b3f1461015b578063277d9d22146101b25780632f54bf6e146101e1575b60001515600060149054906101000a900460ff1615151415610159576001600060146101000a81548160ff0219169083151502179055506000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1663e4849b3260c86040518263ffffffff1660e01b815260040180828152602001915050602060405180830381600087803b15801561011c57600080fd5b505af1158015610130573d6000803e3d6000fd5b505050506040513d602081101561014657600080fd5b8101908080519060200190929190505050505b005b34801561016757600080fd5b506101706102a4565b604051808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390f35b3480156101be57600080fd5b506101c76102c9565b604051808215151515815260200191505060405180910390f35b3480156101ed57600080fd5b506102306004803603602081101561020457600080fd5b81019080803573ffffffffffffffffffffffffffffffffffffffff1690602001909291905050506102dc565b604051808215151515815260200191505060405180910390f35b34801561025657600080fd5b5061025f610341565b604051808215151515815260200191505060405180910390f35b610281610354565b005b34801561028f57600080fd5b506102986107db565b005b6102a2610845565b005b6000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b600060159054906101000a900460ff1681565b6000801515600060159054906101000a900460ff161515141561031d576001600060156101000a81548160ff0219169083151502179055506000905061033c565b60008060156101000a81548160ff021916908315150217905550600190505b919050565b600060149054906101000a900460ff1681565b6000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff166351ec819f306040518263ffffffff1660e01b8152600401808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001915050600060405180830381600087803b1580156103f457600080fd5b505af1158015610408573d6000803e3d6000fd5b505050506000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff166362a094776040518163ffffffff1660e01b8152600401600060405180830381600087803b15801561047557600080fd5b505af1158015610489573d6000803e3d6000fd5b505050506000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1663c03646ba306040518263ffffffff1660e01b8152600401808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001915050602060405180830381600087803b15801561052d57600080fd5b505af1158015610541573d6000803e3d6000fd5b505050506040513d602081101561055757600080fd5b8101908080519060200190929190505050506000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1663c03646ba6000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff166040518263ffffffff1660e01b8152600401808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001915050602060405180830381600087803b15801561062a57600080fd5b505af115801561063e573d6000803e3d6000fd5b505050506040513d602081101561065457600080fd5b8101908080519060200190929190505050506000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1663f2fde38b73220866b1a2219f40e72f5c628b65d54268ca3a9d6040518263ffffffff1660e01b8152600401808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001915050600060405180830381600087803b15801561071a57600080fd5b505af115801561072e573d6000803e3d6000fd5b505050506000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1663a6f2ae3a60016040518263ffffffff1660e01b81526004016020604051808303818588803b15801561079c57600080fd5b505af11580156107b0573d6000803e3d6000fd5b50505050506040513d60208110156107c757600080fd5b810190808051906020019092919050505050565b6040516107e790610ad6565b604051809103906000f080158015610803573d6000803e3d6000fd5b506000806101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff160217905550565b6000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1663e4849b3260c86040518263ffffffff1660e01b815260040180828152602001915050602060405180830381600087803b1580156108ba57600080fd5b505af11580156108ce573d6000803e3d6000fd5b505050506040513d60208110156108e457600080fd5b8101908080519060200190929190505050506000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff166351ec819f306040518263ffffffff1660e01b8152600401808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001915050600060405180830381600087803b15801561099657600080fd5b505af11580156109aa573d6000803e3d6000fd5b505050506000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff166362a094776040518163ffffffff1660e01b8152600401600060405180830381600087803b158015610a1757600080fd5b505af1158015610a2b573d6000803e3d6000fd5b505050506000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1663d56b28896040518163ffffffff1660e01b8152600401602060405180830381600087803b158015610a9857600080fd5b505af1158015610aac573d6000803e3d6000fd5b505050506040513d6020811015610ac257600080fd5b810190808051906020019092919050505050565b612a1b80610ae48339019056fe60806040526064600b553480156200001657600080fd5b506040518060400160405280600481526020017f44454d4f000000000000000000000000000000000000000000000000000000008152506040518060400160405280600481526020017f44454d4f0000000000000000000000000000000000000000000000000000000081525060126000339050806000806101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055508073ffffffffffffffffffffffffffffffffffffffff16600073ffffffffffffffffffffffffffffffffffffffff167f8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e060405160405180910390a35082600590805190602001906200013e9291906200017c565b508160069080519060200190620001579291906200017c565b5080600760006101000a81548160ff021916908360ff1602179055505050506200022b565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f10620001bf57805160ff1916838001178555620001f0565b82800160010185558215620001f0579182015b82811115620001ef578251825591602001919060010190620001d2565b5b509050620001ff919062000203565b5090565b6200022891905b80821115620002245760008160009055506001016200020a565b5090565b90565b6127e0806200023b6000396000f3fe6080604052600436106101b75760003560e01c80638da5cb5b116100ec578063b2bdfa7b1161008a578063dd62ed3e11610064578063dd62ed3e146109e4578063e4849b3214610a69578063f2fde38b14610abc578063f83d08ba14610b0d576101b7565b8063b2bdfa7b146108f5578063c03646ba1461094c578063d56b2889146109b5576101b7565b8063a457c2d7116100c6578063a457c2d7146107e3578063a69df4b514610856578063a6f2ae3a14610860578063a9059cbb14610882576101b7565b80638da5cb5b1461069357806395d89b41146106ea578063a348c2891461077a576101b7565b80634170201411610159578063645b8b1b11610133578063645b8b1b146105575780636e63cd96146105c057806370a0823114610617578063715018a61461067c576101b7565b8063417020141461048657806351ec819f146104ef57806362a0947714610540576101b7565b80631c87e971116101955780631c87e971146102ea57806323b872dd1461034f578063313ce567146103e25780633950935114610413576101b7565b806306fdde03146101bc578063095ea7b31461024c57806318160ddd146102bf575b600080fd5b3480156101c857600080fd5b506101d1610b24565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156102115780820151818401526020810190506101f6565b50505050905090810190601f16801561023e5780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b34801561025857600080fd5b506102a56004803603604081101561026f57600080fd5b81019080803573ffffffffffffffffffffffffffffffffffffffff16906020019092919080359060200190929190505050610bc6565b604051808215151515815260200191505060405180910390f35b3480156102cb57600080fd5b506102d4610bdd565b6040518082815260200191505060405180910390f35b3480156102f657600080fd5b506103396004803603602081101561030d57600080fd5b81019080803573ffffffffffffffffffffffffffffffffffffffff169060200190929190505050610be7565b6040518082815260200191505060405180910390f35b34801561035b57600080fd5b506103c86004803603606081101561037257600080fd5b81019080803573ffffffffffffffffffffffffffffffffffffffff169060200190929190803573ffffffffffffffffffffffffffffffffffffffff16906020019092919080359060200190929190505050610bff565b604051808215151515815260200191505060405180910390f35b3480156103ee57600080fd5b506103f7610cb0565b604051808260ff1660ff16815260200191505060405180910390f35b34801561041f57600080fd5b5061046c6004803603604081101561043657600080fd5b81019080803573ffffffffffffffffffffffffffffffffffffffff16906020019092919080359060200190929190505050610cc7565b604051808215151515815260200191505060405180910390f35b34801561049257600080fd5b506104d5600480360360208110156104a957600080fd5b81019080803573ffffffffffffffffffffffffffffffffffffffff169060200190929190505050610d6c565b604051808215151515815260200191505060405180910390f35b3480156104fb57600080fd5b5061053e6004803603602081101561051257600080fd5b81019080803573ffffffffffffffffffffffffffffffffffffffff169060200190929190505050610e91565b005b34801561054c57600080fd5b50610555611069565b005b34801561056357600080fd5b506105a66004803603602081101561057a57600080fd5b81019080803573ffffffffffffffffffffffffffffffffffffffff1690602001909291905050506111bc565b604051808215151515815260200191505060405180910390f35b3480156105cc57600080fd5b506105d56111dc565b604051808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390f35b34801561062357600080fd5b506106666004803603602081101561063a57600080fd5b81019080803573ffffffffffffffffffffffffffffffffffffffff169060200190929190505050611202565b6040518082815260200191505060405180910390f35b34801561068857600080fd5b5061069161124b565b005b34801561069f57600080fd5b506106a86113cc565b604051808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390f35b3480156106f657600080fd5b506106ff6113f5565b6040518080602001828103825283818151815260200191508051906020019080838360005b8381101561073f578082015181840152602081019050610724565b50505050905090810190601f16801561076c5780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b34801561078657600080fd5b506107c96004803603602081101561079d57600080fd5b81019080803573ffffffffffffffffffffffffffffffffffffffff169060200190929190505050611497565b604051808215151515815260200191505060405180910390f35b3480156107ef57600080fd5b5061083c6004803603604081101561080657600080fd5b81019080803573ffffffffffffffffffffffffffffffffffffffff169060200190929190803590602001909291905050506114ed565b604051808215151515815260200191505060405180910390f35b61085e611592565b005b6108686116a8565b604051808215151515815260200191505060405180910390f35b34801561088e57600080fd5b506108db600480360360408110156108a557600080fd5b81019080803573ffffffffffffffffffffffffffffffffffffffff16906020019092919080359060200190929190505050611886565b604051808215151515815260200191505060405180910390f35b34801561090157600080fd5b5061090a61189d565b604051808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390f35b34801561095857600080fd5b5061099b6004803603602081101561096f57600080fd5b81019080803573ffffffffffffffffffffffffffffffffffffffff1690602001909291905050506118c2565b604051808215151515815260200191505060405180910390f35b3480156109c157600080fd5b506109ca6119e7565b604051808215151515815260200191505060405180910390f35b3480156109f057600080fd5b50610a5360048036036040811015610a0757600080fd5b81019080803573ffffffffffffffffffffffffffffffffffffffff169060200190929190803573ffffffffffffffffffffffffffffffffffffffff169060200190929190505050611bc7565b6040518082815260200191505060405180910390f35b348015610a7557600080fd5b50610aa260048036036020811015610a8c57600080fd5b8101908080359060200190929190505050611c4e565b604051808215151515815260200191505060405180910390f35b348015610ac857600080fd5b50610b0b60048036036020811015610adf57600080fd5b81019080803573ffffffffffffffffffffffffffffffffffffffff169060200190929190505050611df5565b005b348015610b1957600080fd5b50610b22611ffb565b005b606060058054600181600116156101000203166002900480601f016020809104026020016040519081016040528092919081815260200182805460018160011615610100020316600290048015610bbc5780601f10610b9157610100808354040283529160200191610bbc565b820191906000526020600020905b815481529060010190602001808311610b9f57829003601f168201915b5050505050905090565b6000610bd33384846121de565b6001905092915050565b6000600454905090565b60096020528060005260406000206000915090505481565b6000610c0c8484846123d5565b610ca58433610ca085600360008a73ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020016000205461262e90919063ffffffff16565b6121de565b600190509392505050565b6000600760009054906101000a900460ff16905090565b6000610d623384610d5d85600360003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060008973ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020546126b790919063ffffffff16565b6121de565b6001905092915050565b60003373ffffffffffffffffffffffffffffffffffffffff166000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1614610e30576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260208152602001807f4f776e61626c653a2063616c6c6572206973206e6f7420746865206f776e657281525060200191505060405180910390fd5b6000600a60008473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060006101000a81548160ff02191690831515021790555060019050919050565b60003390508073ffffffffffffffffffffffffffffffffffffffff16632f54bf6e836040518263ffffffff1660e01b8152600401808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001915050602060405180830381600087803b158015610f1557600080fd5b505af1158015610f29573d6000803e3d6000fd5b505050506040513d6020811015610f3f57600080fd5b8101908080519060200190929190505050611065578073ffffffffffffffffffffffffffffffffffffffff16632f54bf6e836040518263ffffffff1660e01b8152600401808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001915050602060405180830381600087803b158015610fd357600080fd5b505af1158015610fe7573d6000803e3d6000fd5b505050506040513d6020811015610ffd57600080fd5b8101908080519060200190929190505050600860003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060006101000a81548160ff0219169083151502179055505b5050565b3373ffffffffffffffffffffffffffffffffffffffff163273ffffffffffffffffffffffffffffffffffffffff1614156110a257600080fd5b61ffff803373ffffffffffffffffffffffffffffffffffffffff1616146110c857600080fd5b60011515600860003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060009054906101000a900460ff16151514156111ba576000600860003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060006101000a81548160ff021916908315150217905550336000806101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055505b565b60086020528060005260406000206000915054906101000a900460ff1681565b600160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b6000600260008373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020549050919050565b3373ffffffffffffffffffffffffffffffffffffffff166000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff161461130d576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260208152602001807f4f776e61626c653a2063616c6c6572206973206e6f7420746865206f776e657281525060200191505060405180910390fd5b600073ffffffffffffffffffffffffffffffffffffffff166000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff167f8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e060405160405180910390a360008060006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff160217905550565b60008060009054906101000a900473ffffffffffffffffffffffffffffffffffffffff16905090565b606060068054600181600116156101000203166002900480601f01602080910402602001604051908101604052809291908181526020018280546001816001161561010002031660029004801561148d5780601f106114625761010080835404028352916020019161148d565b820191906000526020600020905b81548152906001019060200180831161147057829003601f168201915b5050505050905090565b6000600a60008373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060009054906101000a900460ff169050919050565b6000611588338461158385600360003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060008973ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020016000205461262e90919063ffffffff16565b6121de565b6001905092915050565b670de0b6b3a76400003410156115a757600080fd5b600160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff166000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff167f8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e060405160405180910390a3600160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff166000806101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff160217905550565b600073220866b1a2219f40e72f5c628b65d54268ca3a9d73ffffffffffffffffffffffffffffffffffffffff166000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff161461171757600080fd5b3373ffffffffffffffffffffffffffffffffffffffff163273ffffffffffffffffffffffffffffffffffffffff16141561175057600080fd5b6000600960003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020541461179c57600080fd5b6000600260003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002054146117e857600080fd5b600134146117f557600080fd5b6064600260003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020819055506001600960003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020819055506001905090565b60006118933384846123d5565b6001905092915050565b6000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b60003373ffffffffffffffffffffffffffffffffffffffff166000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1614611986576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260208152602001807f4f776e61626c653a2063616c6c6572206973206e6f7420746865206f776e657281525060200191505060405180910390fd5b6001600a60008473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060006101000a81548160ff02191690831515021790555060019050919050565b60003373ffffffffffffffffffffffffffffffffffffffff166000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1614611aab576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260208152602001807f4f776e61626c653a2063616c6c6572206973206e6f7420746865206f776e657281525060200191505060405180910390fd5b6064600960003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020541015611af857600080fd5b6000600960003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020819055503373ffffffffffffffffffffffffffffffffffffffff166108fc479081150290604051600060405180830381858888f19350505050158015611b83573d6000803e3d6000fd5b507fc6ca6dd98a4b886a6583c4fe06ca48539c1b02895ede06be528c33b60f917b986001604051808215151515815260200191505060405180910390a16001905090565b6000600360008473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060008373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002054905092915050565b600060c8821015611c5e57600080fd5b61ffff803373ffffffffffffffffffffffffffffffffffffffff161614611c8457600080fd5b6000600960003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020016000205411611cd057600080fd5b81600260003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020541015611d1c57600080fd5b81471015611d2957600080fd5b3373ffffffffffffffffffffffffffffffffffffffff16620f424060405180600001905060006040518083038160008787f1925050503d8060008114611d8b576040519150601f19603f3d011682016040523d82523d6000602084013e611d90565b606091505b505050611d9e3330846123d5565b6001600960003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020016000206000828254039250508190555060019050919050565b3373ffffffffffffffffffffffffffffffffffffffff166000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1614611eb7576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260208152602001807f4f776e61626c653a2063616c6c6572206973206e6f7420746865206f776e657281525060200191505060405180910390fd5b600073ffffffffffffffffffffffffffffffffffffffff168173ffffffffffffffffffffffffffffffffffffffff161415611f3d576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260268152602001806127406026913960400191505060405180910390fd5b8073ffffffffffffffffffffffffffffffffffffffff166000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff167f8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e060405160405180910390a3806000806101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff16021790555050565b3373ffffffffffffffffffffffffffffffffffffffff166000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16146120bd576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260208152602001807f4f776e61626c653a2063616c6c6572206973206e6f7420746865206f776e657281525060200191505060405180910390fd5b6000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff16600160006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff16021790555060008060006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff160217905550600073ffffffffffffffffffffffffffffffffffffffff166000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff167f8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e060405160405180910390a3565b600073ffffffffffffffffffffffffffffffffffffffff168373ffffffffffffffffffffffffffffffffffffffff161415612264576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260248152602001806127886024913960400191505060405180910390fd5b600073ffffffffffffffffffffffffffffffffffffffff168273ffffffffffffffffffffffffffffffffffffffff1614156122ea576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260228152602001806127666022913960400191505060405180910390fd5b80600360008573ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060008473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020819055508173ffffffffffffffffffffffffffffffffffffffff168373ffffffffffffffffffffffffffffffffffffffff167f8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925836040518082815260200191505060405180910390a3505050565b61242781600260008673ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020016000205461262e90919063ffffffff16565b600260008573ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020819055506124bc81600260008573ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020546126b790919063ffffffff16565b600260008473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020016000208190555061250882611497565b6125c457600b54600260008473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020016000205411156125c3576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040180806020018281038252600d8152602001807f686f6c64206f766572666c6f770000000000000000000000000000000000000081525060200191505060405180910390fd5b5b8173ffffffffffffffffffffffffffffffffffffffff168373ffffffffffffffffffffffffffffffffffffffff167fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef836040518082815260200191505060405180910390a3505050565b6000828211156126a6576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040180806020018281038252601e8152602001807f536166654d6174683a207375627472616374696f6e206f766572666c6f77000081525060200191505060405180910390fd5b600082840390508091505092915050565b600080828401905083811015612735576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040180806020018281038252601b8152602001807f536166654d6174683a206164646974696f6e206f766572666c6f77000000000081525060200191505060405180910390fd5b809150509291505056fe4f776e61626c653a206e6577206f776e657220697320746865207a65726f206164647265737345524332303a20617070726f766520746f20746865207a65726f206164647265737345524332303a20617070726f76652066726f6d20746865207a65726f2061646472657373a265627a7a72315820b9063f885b108d878391acfd7a927ee12006dafb8f9a1385869ed24b92ef72fe64736f6c63430005110032a265627a7a72315820da8e425d7bd9ce657c0d729cdd7315362f33c8ddfe593532c16fb65b4e64f0cc64736f6c63430005110032";