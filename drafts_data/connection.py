# Relevant imports, includ. requests library - used for making HTTP requests, and
# web3 library, to help us access the ETH blockchain.
# Load dotenv to keep private keys and info safe. 
import requests
import json
import os

from pathlib import Path
from web3.auto import w3
from dotenv import load_dotenv
load_dotenv()

# Create a headers dict including api_key values from .env.
headers = {
    "Content-type": "application/json",
    "pinata_api_key": os.getenv("PINATA_API_KEY"),
    "pinata_secret_api_key": os.getenv("PINATA_SECRET_API_KEY"),
}

# Initilize the contract.
def initContract():
# Access and load the Application Binary Interface (ABI) so that the client 
# can make contact with the smart contract. Once the smart contract is contacted, 
# use w3.eth.contract to connect to the contract.
    with open(Path("EduToken.json")) as json_file:
        abi = json.load(json_file)
    return w3.eth.contract(address=os.getenv("EduToken_ADDRESS"), abi=abi)

# Take the data dict and convert it into json string. We are using the school
# semester system and a description to properly disperse tokens. 
def convertDataToJSON(semester, description):
    data = {
        "pinataOptions": {"cidVersion": 1},
        "pinataContent": {
            "name": "reward Report",
            "description": description,
            "image": "ipfs://bafybeihsecbomd7gbu6qjnvs7jinlxeufujqzuz3ccazmhvkszsjpzzrsu",
            "semester": semester,
        },
    }
    return json.dumps(data)

# Pin the json object to the Interplanetary File System (IPFS) so that this info 
# is never deleted by an IPFS node.
def pinJSONtoIPFS(json):
    r = requests.post(
        "https://api.pinata.cloud/pinning/pinJSONToIPFS", data=json, headers=headers
    )
    ipfs_hash = r.json()["IpfsHash"]
    return f"ipfs://{ipfs_hash}"

