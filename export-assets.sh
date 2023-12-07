#!/bin/sh
asset_directory="assets/animals"
sizes=($(jq -r '.[]' "scripts/sizes.json"))

function export_sizes {
    find "$asset_directory" -type f -name "*.svg" | while read -r old; do
        for size in "${sizes[@]}"; do
            new=$(echo "$old" | sed -e "s/assets\/animals/resources\/drawables\/characters\/$size/")
            directory_path="$(dirname "$new")"
            filename="$(basename "$new")"
            
            if [ ! -e "$new" ]; then
                mkdir -p "$directory_path"
                touch "$filename"
            fi
            
            rsvg-convert "$old" -w "$size" -h "$size" -f svg -o "$new"
            echo
            echo "✅ Finished converting $old to $new"
        done
        echo
    done
}

function update_drawables_xml {
    python3 scripts/update_drawables_xml.py
}

function update_garmagotchi_assets_mc {
    # Clear file
    > source/garmagotchiAssets.mc

    echo "class GarmagotchiAssets {" >> source/garmagotchiAssets.mc
    echo "  public var characters;" >> source/garmagotchiAssets.mc
    echo "  function initialize() {" >> source/garmagotchiAssets.mc
    echo "    self.characters = {" >> source/garmagotchiAssets.mc
    
    animal_names=($(find "$asset_directory" -type d -mindepth 1 -maxdepth 1 -exec basename {} \;))
    for animal_name in "${animal_names[@]}"; do
        animal_pascal_case=$(echo "$animal_name" | awk 'BEGIN{FS="-";OFS=""}{for(i=1;i<=NF;i++)$i=toupper(substr($i,1,1)) substr($i,2)}1')
        animal_camel_case=$(echo $animal_name | awk 'BEGIN{FS="-";OFS=""}{for(i=1;i<=NF;i++){if(i>1)$i=toupper(substr($i,1,1)) substr($i,2)}}1')
        echo "      \""$animal_camel_case"\" => {" >> source/garmagotchiAssets.mc
        file_names=($(find "$asset_directory/$animal_name" -type f -name "*.svg" -exec basename {} \;))
        for file_name in "${file_names[@]}"; do
            stripped_file_name="${file_name%.svg}"
            file_pascal_case=$(echo "$stripped_file_name" | awk 'BEGIN{FS="_";OFS=""}{for(i=1;i<=NF;i++)$i=toupper(substr($i,1,1)) substr($i,2)}1')
            file_camel_case=$(echo $stripped_file_name | awk 'BEGIN{FS="_";OFS=""}{for(i=1;i<=NF;i++){if(i>1)$i=toupper(substr($i,1,1)) substr($i,2)}}1')
            echo "        \""$file_camel_case"\" => new BitmapAsset({" >> source/garmagotchiAssets.mc
            for size in "${sizes[@]}"; do
                echo "          \""$size"\" => Rez.Drawables."$animal_pascal_case""$file_pascal_case""$size"," >> source/garmagotchiAssets.mc
            done
            echo "        })," >> source/garmagotchiAssets.mc
        done
        echo "      }," >> source/garmagotchiAssets.mc
    done
    
    echo "    };" >> source/garmagotchiAssets.mc
    echo "  }" >> source/garmagotchiAssets.mc
    echo "}" >> source/garmagotchiAssets.mc
}

echo
echo "✨ Starting to export all character sizes!"
export_sizes
echo
echo "🎉 Finished exporting all character sizes!"

echo
echo "✨ Starting to update drawables.xml!"
update_drawables_xml
echo
echo "🎉 Finished updating drawables.xml!"

echo
echo "✨ Starting to update garmagotchiAssets.xml!"
update_garmagotchi_assets_mc
echo
echo "🎉 Finished updating garmagotchiAssets.xml!"