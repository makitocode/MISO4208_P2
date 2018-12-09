const compareImages = require('resemblejs/compareImages');
const fs = require("mz/fs");

async function getDiff(imgIni, imgFinal, resultado){

    const options = {
        output: {
            errorColor: {
                red: 255,
                green: 0,
                blue: 255
            },
            errorType: 'movement',
            transparency: 1,
            largeImageThreshold: 1200,
            useCrossOrigin: false,
            outputDiff: true
        },
        scaleToSameSize: true,
        ignore: ['less'],
    };
    try {
        const data = await
        compareImages(
            await fs.readFile(imgIni),
            await fs.readFile(imgFinal),
            options
        );

        console.log(JSON.stringify(data));

        await fs.writeFile(resultado, data.getBuffer());
    }
    catch (err) {
        console.log(err)
    }
}

getDiff(process.argv[2],
        process.argv[3],
        process.argv[4]);