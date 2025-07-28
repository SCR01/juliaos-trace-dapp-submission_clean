const hre = require("hardhat");

async function main() {
  const TraceContract = await hre.ethers.getContractFactory("TraceContract");
  const traceContract = await TraceContract.deploy();

  await traceContract.deployed();

  console.log(
    `TraceContract deployed to ${traceContract.address}`
  );
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});


