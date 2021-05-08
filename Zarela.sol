// wallet => balance , transfer , ... 
// orderboard => everyone can see that => 
// create_orderboard => order details set by requester
// get_order
// contribute

// ui/ux

// 1- create_orderboard
// 2- orderboard  => contribute
// 3- get_responses;
// SPDX-License-Identifier: GPL-3.0
pragma experimental ABIEncoderV2;
pragma solidity >=0.6.0 <0.8.0;
import "./CheckPrice.sol";
import "./ERC20.sol";
import "./Tools.sol";
import "./SafeMath.sol";

// Initiate Biobit Token With 200M Total Supply And Set Name, Symbol

contract ZarelaSmartContract is ERC20,PriceConsumerV3 {
    IERC20 private token;
    address payable public owner;
    constructor(IERC20 BioBit)ERC20("BioBit","BBit")  public {
        owner = msg.sender;
        _totalSupply = 200000000;
        _balances[owner] = _totalSupply;
        token = BioBit;
    }
    
    struct Requester{
        address Requester_Address;
    }
    
    struct OrderFile{
        address Requester_Address_Creator;
        uint Order_Number;
        uint Token_Pay;
        uint Instance_Count;
        string White_Paper; //ipfs
        string Task; //ipfs
        uint Instance_Remains;
        string What_Type; //category
    }
    struct OrderSurvey{
        address Requester_Address_Creator;
        uint Order_Number;
        uint Token_Pay;
        uint Instance_Count;
        string Description;
        uint Instance_Remains;
        string What_Type;
    }
    struct Payment{
        address Requester_Address_Creator;
        uint Order_Number;
        uint Token_Pay;
        uint Instance_Count;
        string Description;
        uint Instance_Remains;
        address reciever_address;
        uint amount;
        address _sender_address;
    }
    
    struct User{
        address User_Address;
    }
    struct Data{
        uint Order_Number;
        string[] Data;
        address[] User_Address;
    }
    struct vote{
        uint Order_Number;
    }
    mapping (address=> Payment) public pay_map;
    mapping(uint => OrderFile)public Order_File;
    mapping(uint => OrderSurvey)public Order_Survey;
    mapping(uint => Data) public Data_Map;
    
    OrderFile[]public ord_file;
    OrderSurvey[]public ord_survey;
    

    function payments(address _reciever_address , uint amount , address _Requester_Address_Creator)public{
        if(amount == 1000){
            pay_map[msg.sender]._sender_address = msg.sender;
            pay_map[_reciever_address].reciever_address = _reciever_address;
            pay_map[_Requester_Address_Creator].Requester_Address_Creator = _Requester_Address_Creator;
            _balances[msg.sender] = _balances[msg.sender] - amount; 
            _balances[_reciever_address] = _balances[_reciever_address] + amount;
            _balances[_Requester_Address_Creator] = _balances[_Requester_Address_Creator] - 1500;
            _balances[msg.sender] = _balances[msg.sender] + 1500;
        }
    }
    
    
    function SetOrderSurvey(uint _Token_Pay,uint _Instance_Count,string memory _Description,string memory _Category)public{
        uint id = ord_survey.length;
        Order_Survey[id].What_Type = _Category;
        string memory Type = Order_Survey[id].What_Type;
        ord_survey.push(OrderSurvey(msg.sender,id,_Token_Pay,_Instance_Count,_Description,_Instance_Count,Type));
    }
    
    function SetOrderFile(uint _Token_Pay,uint _Instance_Count,string memory _White_Paper,string memory _Task,string memory _Category )public {
        require(_balances[msg.sender] >= _Token_Pay , "Your Token Is Not Enough");
        uint id = ord_file.length;
        Order_File[id].What_Type = _Category;
        string memory Type = Order_File[id].What_Type;
        ord_file.push(OrderFile(msg.sender,id,_Token_Pay,_Instance_Count,_White_Paper,_Task,_Instance_Count,Type));
    }
    
    function SendOrderSurvey(uint _order_number)public{
        
    }
    
    function SendOrderFile(uint _Order_Number, string memory _User_File) public{
        Data_Map[_Order_Number].Data.push(_User_File);
    }
    function GetOrderFile(uint _Order_Number)public view returns(string memory){
        OrderFile storage myorder = ord_file[_Order_Number];
        require(myorder.Requester_Address_Creator == msg.sender);
        string memory str = "";
        for (uint i ; i<  Data_Map[_Order_Number].Data.length ; i++){
            str = Tools.concatstring(str, " : Hash =>>  ");
            str = Tools.concatstring(str,  Data_Map[_Order_Number].Data[i]) ;
            str = Tools.concatstring(str , "  >> ");
            if( i !=  Data_Map[_Order_Number].Data.length - 1){
                str =  Tools.concatstring(str , ",");
            }
        }

        return(str);
    }
    function SendOrderFile(uint _Order_Number, string memory _User_File,address _Requester_Address,address _Center) public{
    }
}
