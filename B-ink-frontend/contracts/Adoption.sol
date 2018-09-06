pragma solidity ^0.4.17;

contract Adoption {
    address[16] public adopters;
    struct UserStruct {
        address userAddress;
        string username;
        string password;
        uint time;
        uint index;
    }

    struct UserListStruct {
        address userAddress;
        uint index;
    }

    address[] public userAddresses; 
    string[] private usernames;
    mapping(address => UserStruct) private userStruct;

    mapping(string => UserListStruct) private userListStruct; 
    function adopt(uint petId) public returns (uint) {
        require(petId>=0 && petId <= 15);
        adopters[petId] = msg.sender;
        return petId;
    }

    function login(string username, string password) public returns (bool) {
        
    }

    function findUserAddressByUsername(string _username) public constant returns (address userAddress) {
        require(isExitUsername(_username));
        return userListStruct[_username].userAddress;
    }


    //创建用户信息
    function createUser(address _userAddress, string _password, string _username) public returns (uint index) {
        require(!isExitUserAddress(_userAddress)); //如果地址已存在则不允许再创建

        userAddresses.push(_userAddress); //地址集合push新地址
        userStruct[_userAddress] = UserStruct(_userAddress, _username, _password, now, userAddresses.length - 1);

        usernames.push(_username); //用户名集合push新用户
        userListStruct[_username] = UserListStruct(_userAddress, usernames.length - 1); //用户所对应的地址集合

        return userAddresses.length - 1;
    }


    //获取用户个人信息
    function findUser(address _userAddress) public constant returns (address userAddresses, string username, string password, uint time, uint index) {
        require(isExitUserAddress(_userAddress));
        return (
            userStruct[_userAddress].userAddress,
            userStruct[_userAddress].username,
            userStruct[_userAddress].password,
            userStruct[_userAddress].time,
            userStruct[_userAddress].index
        ); 
    }

    function isExitUsername(string _username) public constant returns(bool) {
        if (usernames.length == 0) return false;
        return (keccak256(usernames[userListStruct[_username].index]) == keccak256(_username));
    }

    function isExitUserAddress(address _userAddress) public constant returns(bool) {
        if (userAddresses.length == 0) return false;
        return (userAddresses[userStruct[_userAddress].index] == _userAddress);
    }


    function getAdopters() public view returns (address[16]) {
        return adopters;
    }
}