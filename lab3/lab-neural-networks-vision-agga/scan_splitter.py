import cv2
import numpy as np
import argparse 

def cut_samples(in_img_path, out_dir, result_img_path=None, invert_output=False, sample_area=1000, grid_area=50000):
    # Load image, grayscale, and adaptive threshold
    image  = cv2.imread(in_img_path)
    gray   = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    thresh = cv2.adaptiveThreshold(gray,255,cv2.ADAPTIVE_THRESH_GAUSSIAN_C, cv2.THRESH_BINARY_INV,57,5)

    # Filters images by erasing (setting to false) every contour
    # smaller than sample_area (including cells themselves)
    # Should leave only grid
    (cnts, _) = cv2.findContours(thresh, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
    cnts = list(filter(lambda c : cv2.contourArea(c) < sample_area, cnts))
    cv2.drawContours(thresh, cnts, -1, (0,0,0), -1)

    # Fix horizontal and vertical lines
    vertical_kernel = cv2.getStructuringElement(cv2.MORPH_RECT, (1,5))
    thresh = cv2.morphologyEx(thresh, cv2.MORPH_CLOSE, vertical_kernel, iterations=9)
    horizontal_kernel = cv2.getStructuringElement(cv2.MORPH_RECT, (5,1))
    thresh = cv2.morphologyEx(thresh, cv2.MORPH_CLOSE, horizontal_kernel, iterations=4)

    # Invert grid colors
    # Then every cell becomes a boolean true
    # However, area outside grid becomes a true as well and must be filtered 
    invert = 255 - thresh
    (cnts, _) = cv2.findContours(invert, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
    cnts = list(filter(lambda c : cv2.contourArea(c) < grid_area, cnts)) 

    # Cut cell masks from grayscale image
    # Downscale to necessary format (looses ton of quality)
    for j, c in enumerate(cnts, 1):
        x, y, w, h = cv2.boundingRect(c)
        split = gray[y:y+h, x:x+w]
        scaled_split = cv2.resize(split, (32, 32), interpolation=cv2.INTER_AREA)
        if invert_output:
            scaled_split = 255 - scaled_split
        cv2.imwrite(f"{out_dir}/split{j}.png", scaled_split)

    if result_img_path is not None:
        mask = np.zeros_like(gray)
        cv2.drawContours(mask, cnts, -1, (255, 255, 255), -1)
        if invert_output:
            gray = 255 - gray
        cv2.imwrite(result_img_path, cv2.bitwise_and(gray, mask))

def main():
    desc = "Cuts out cells in grid of samples into seperate images"
    parser = argparse.ArgumentParser(description=desc)

    parser.add_argument("-i", "--input",
                        help="Input file to be split",
                        required=True,
                        type=str)
    parser.add_argument("-o", "--output",
                        help="Output directory for samples",
                        required=True,
                        type=str)
    parser.add_argument("-r", "--result",
                        help="Return cut areas of input file in image form",
                        type=str,
                        default=None)
    parser.add_argument("--invert",
                        help="Inverts colors of resulting splits",
                        action='store_true')
    parser.add_argument("--sample-area",
                        help="Max possible area of samples (in pixels) (default: %(default)s)",
                        type=int,
                        default=1000)
    parser.add_argument("--grid-area",
                        help="Area of grid (in pixels) (default: %(default)s)",
                        type=int,
                        default=50000)

    args = parser.parse_args()

    cut_samples(args.input, args.output, args.result, args.invert, args.sample_area, args.grid_area)

    
if __name__ == "__main__":
    main()
