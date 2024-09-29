import json

def add_api_proposal(json_data, new_proposal):
    """
    Adds a new proposal to the enabledApiProposals list in the given JSON data.

    :param json_data: A string containing the JSON data.
    :param new_proposal: The proposal to add to enabledApiProposals.
    :return: The updated JSON data as a string.
    """
    try:
        # Parse the JSON data
      #  data = json.loads(json_data)
        data = json_data

        # Check if the key 'enabledApiProposals' exists
        if 'enabledApiProposals' in data:
            # Add the new proposal to the list if it's not already present
            if new_proposal not in data['enabledApiProposals']:
                data['enabledApiProposals'].append(new_proposal)
        else:
            print("No 'enabledApiProposals' key found in the JSON data.")

        # Return the updated JSON data
        return json.dumps(data, indent=4)

    except json.JSONDecodeError as e:
        print(f"Error parsing JSON: {e}")
        return None


with open('package.json') as f:
    json_input = json.load(f)
#    print(d)

# Call the function
new_proposal = "terminalShellIntegration"
updated_json = add_api_proposal(json_input, new_proposal)
print(updated_json)
