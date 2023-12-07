import xml.etree.ElementTree as ET
import os
import json

def kebab_to_pascal(string):
    words = string.split('-')
    pascal_case = ''.join(word.capitalize() for word in words)
    return pascal_case

def snake_to_pascal(string):
    words = string.split('_')
    pascal_case = ''.join(word.capitalize() for word in words)
    return pascal_case

def write_size_animal_and_asset_to_xml(root, size, animal, asset):
    new_element = ET.SubElement(root, "bitmap")
    new_element.set("id", kebab_to_pascal(animal) + os.path.splitext(snake_to_pascal(asset))[0] + size)
    new_element.set("filename", "characters/" + size + "/" + animal + "/" + asset)
    new_element.set("dithering", "none")
    new_element.set("compress", "true")

def write_launcher_icon_to_xml(root):
    new_elemment = ET.SubElement(root, "bitmap")
    new_elemment.set("id", "LauncherIcon")
    new_elemment.set("filename", "launcher_icon.png")

# Get and clear the XML file
tree = ET.parse("resources/drawables/drawables.xml")
root = tree.getroot()
root.clear()

# Get the list of animals
animals_folder_path = "assets/animals"
animal_folder_path_items = os.listdir(animals_folder_path)
animals = [item for item in animal_folder_path_items if os.path.isdir(os.path.join(animals_folder_path, item))]

# Get the list of sizes
with open("scripts/sizes.json", "r") as json_file:
    sizes = json.load(json_file)

# Mandatory launcher icon
write_launcher_icon_to_xml(root)

for animal in animals:
    animal_directory = animals_folder_path + "/" + animal
    asset_file_list = [f for f in os.listdir(animal_directory) if os.path.isfile(os.path.join(animal_directory, f)) & f.endswith(".svg")]

    for size in sizes:
        for asset in asset_file_list:
            write_size_animal_and_asset_to_xml(root, size, animal, asset)

tree.write("resources/drawables/drawables.xml")

