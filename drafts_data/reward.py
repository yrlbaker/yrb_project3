import sys
from crypto import convertDataToJSON, pinJSONtoIPFS, initContract, w3

from pprint import pprint

# what do we change cryptofax to?
cryptofax = initContract()


def create_token_request():
    time = input("Date of the accident: ")
    description = input("Description of the accident: ")
    token_id = int(input("Token ID: "))

    json_data = convertDataToJSON(time, description)
    report_uri = pinJSONtoIPFS(json_data)

    return token_id, report_uri


def requestEduToken(token_id, report_uri):
    tx_hash = cryptofax.functions.request_edu_Token(token_id, report_uri).transact(
        {"from": w3.eth.accounts[0]}
    )
    receipt = w3.eth.waitForTransactionReceipt(tx_hash)
    return receipt


def get_token_request(token_id):
    token_request_filter = cryptofax.events.token_request.createFilter(
        fromBlock="0x0", argument_filters={"token_id": token_id}
    )
    return token_request_filter.get_all_entries()


# sys.argv is the list of arguments passed from the command line
# sys.argv[0] is always the name of the script
# sys.argv[1] is the first argument, and so on
# For example:
#        sys.argv[0]        sys.argv[1]    sys.argv[2]
# python accident.py        report
# python accident.py        get            1
def main():
    if sys.argv[1] == "report":
        token_id, report_uri = create_token_request()

        receipt = request_edu_Token(token_id, report_uri)

        pprint(receipt)
        print("Report IPFS Hash:", report_uri)

    if sys.argv[1] == "get":
        token_id = int(sys.argv[2])

        car = cryptofax.functions.cars(token_id).call()
        reports = get_token_request(token_id)

        pprint(reports)
        print("VIN", car[0], "has been in", car[1], "accidents.")


main()
