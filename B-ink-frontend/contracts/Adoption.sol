pragma solidity ^0.4.17;

contract Adoption {
    struct InsurancePart1 {
        string wall;
        string floor;
        string bar;
        string paint;
        string stone;
        string radio1;
        address userAddress;
        uint time;
    }

    struct InsurancePart2 {
        string city;
        uint money;
        uint expense;
        uint time;
    }
    
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
    InsurancePart1[] public insurancePart1s;
    InsurancePart2[] public insurancePart2s;
    uint public insurancePart1Len;
    uint public insurancePart2Len;
    mapping(address => UserStruct) private userStruct;
    mapping(address => uint[]) private insuranceMap;
    mapping(string => UserListStruct) private userListStruct;

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

    function saveInsurancePart1( string wall, string floor, string bar, string paint, string stone, string radio1, address userAddress)
     public returns(bool){
        insurancePart1s.push(InsurancePart1(wall, floor, bar, paint, stone, radio1, userAddress, now));
        insurancePart1Len += 1;
        return true;
    }

    function saveInsurancePart2(string city,uint money, uint expense)
     public returns(bool){
        insurancePart2s.push(InsurancePart2(city,money, expense, now));
        insurancePart2Len += 1;
        return true;
    }
    

}