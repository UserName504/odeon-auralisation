function MidsidefromBformatAuralisation(filenameSource, filenameIR, outputname)

[s fs2]  = audioread(filenameSource); % Load source audio here.
[IR fs1] = audioread(filenameIR);     % Load impulse response here.

if fs1 == fs2 % Ensure that the sample rates align.

MS_IR(:, 1) = IR(:,1) + 0.707*IR(:,3);
MS_IR(:, 2) = IR(:,1) - 0.707*IR(:,3);
N   = length(IR) + length(s);
out = ifft( (fft(s(:,1),N)).*fft(MS_IR, N));
out = out./max(abs(out(:))) * 0.99;
audiowrite(outputname, out, fs1,'BitsPerSample', 24);
else
    disp('Samples rates do not match');
    disp('Make sure source and receiver have same Fs.');
end