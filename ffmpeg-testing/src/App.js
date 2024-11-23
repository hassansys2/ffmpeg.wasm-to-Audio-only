
import './App.css';
import { useEffect, useState } from "react";
import { FFmpeg } from "@ffmpeg/ffmpeg";
import { fetchFile } from "@ffmpeg/util";


function App() {

    const [ffmpegLoad, setMpegLoad] = useState(null)

    const ffmpeg = new FFmpeg({ log: true });


    useEffect(() => {

        const loader = async () => {
            await ffmpeg.load({
                wasmURL: '/ffmpeg-core.wasm',
                coreURL: '/ffmpeg-core.js'
            });
            console.log("Loaded V2");

            await ffmpeg.writeFile('test.wav', await fetchFile('/test.wav'));

            console.log("Read");
            try {

                const downloadFile = (blob, filename) => {
                    const link = document.createElement('a');
                    link.href = URL.createObjectURL(blob);
                    link.download = filename;
                    document.body.appendChild(link); // Required for Firefox
                    link.click();
                    document.body.removeChild(link);
                    URL.revokeObjectURL(link.href);
                };

                await ffmpeg.exec([
                    '-i', 'test.wav',
                    '-t', '300',
                    '-c:a', 'libvorbis',
                    '-b:a', '64k',
                    '-f', 'segment',
                    '-segment_time',
                    '20',
                    `output%03d.ogg`
                ]);

                let segmentIndex = 0;
                let segmentExists = true;

                while (segmentExists) {
                    try {
                        const segmentFilename = `output${String(segmentIndex).padStart(3, '0')}.ogg`;
                        const oggData = await ffmpeg.readFile(segmentFilename);
                        const oggBlob = new Blob([oggData.buffer], { type: 'audio/ogg' });
                        console.log('Segment: ', segmentFilename, 'Blob: ', oggBlob)
                        //downloadFile(oggBlob, segmentFilename);
                        segmentIndex++;
                    } catch (error) {
                        segmentExists = false;
                        console.log('Output error: ', error)
                    }
                }

            } catch (error) {
                console.error(error)
            }
        }

        loader()

    }, [ffmpegLoad]);


    return null
}

export default App;
