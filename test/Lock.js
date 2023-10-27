const {
  loadFixture,
} = require("@nomicfoundation/hardhat-toolbox/network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");

describe("ECediAccount", function () {
  async function deployECediAccount() {
    const [addr0, addr1, addr2, addr3] = await ethers.getSigners();
    const ECediAccount = await ethers.getContractFactory("ECediAccount");
    const eCediAccont = await ECediAccount.deploy();
    return { eCediAccont, addr0, addr1, addr2, addr3 };
  }

  describe("Deployment", () => {
    it("Should deploy without error", async () => {
      await loadFixture(deployECediAccount);
    });
  });
});
